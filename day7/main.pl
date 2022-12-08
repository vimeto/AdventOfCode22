use File::Spec;
use Cwd;
use Data::Dumper;

my $relativePath = "inputs/input.txt";
my $filePath = File::Spec->rel2abs($relativePath);

my %file_contents = ();
my $current_dir = "/";

sub TotalDirectorySize {
  my $array = $_[0];
  my $sum = 0;

  foreach my $value_identifier_array (@{$array}) {
    if (ref($value_identifier_array) eq "ARRAY") {
      my $size = $value_identifier_array->[1];
      $sum += $size;
    }
    else {
      if (exists $file_contents{$value_identifier_array}) {
        $sum += TotalDirectorySize($file_contents{$value_identifier_array});
      }
    }
  }

  return $sum;
}

sub AddFolder {
  my $folder = $_[0];

  if ($current_dir eq "/") {
    $current_dir = "";
  }

  $current_dir = "${current_dir}/$folder";
}

sub RemoveFolder() {
  my $last_slash_index = rindex($current_dir, "/");
  $current_dir = substr($current_dir, 0, $last_slash_index);
}

open(my $file, "<", $filePath) or die "Can't open file: $!";

while (my $line = <$file>) {
  $move_to_regex = '\$ cd (?<f>.+)';
  $list_regex = '\$ ls';
  if ($line =~ m{$move_to_regex}) {
    if ($+{f} eq "..") {
      RemoveFolder();
    }
    elsif ($+{f} eq ".") {
      # do nothing
    }
    elsif ($+{f} eq "/") {
      $current_dir = "/";
    }
    else {
      $a = $+{f};
      AddFolder($a);
    }
  }
  elsif ($line =~ m{$list_regex}) {
  }
  else {
    my $add_this_to_current_dir;
    my ($identifier, $value) = split(" ", $line);
    if ($identifier eq "dir") {
      if ($current_dir eq "/") {
        $add_this_to_current_dir = "/$value";
      }
      else {
        $add_this_to_current_dir = "$current_dir/$value";
      }
    }
    else {

      if (!exists $file_contents{$current_dir}) {
        $file_contents{$current_dir} = [];
      }

      my $integer_identifier = int($identifier);

      # name, size
      $add_this_to_current_dir = [$value => $integer_identifier]
    }
    push(@{$file_contents{$current_dir}}, $add_this_to_current_dir);
  }
}

foreach my $path (sort keys %file_contents) {
  my $joined_values = "";
  foreach my $value_identifier_array (@{$file_contents{$path}}) {
    if (ref($value_identifier_array) eq "ARRAY") {
      my $value = $value_identifier_array->[0];
      my $identifier = $value_identifier_array->[1];
      $joined_values = "$joined_values; $value=$identifier";
    }
    else {
      $joined_values = "$joined_values; $value_identifier_array";
    }
  }
}

my %file_sizes = ();

foreach my $path (keys %file_contents) {
  $file_sizes{$path} = TotalDirectorySize($file_contents{$path});
}

# First part
my $totalsum = 0;
foreach my $path (sort keys %file_sizes) {
  my $value = $file_sizes{$path};
  if ($value < 100000) {
    $totalsum += $value;
  }
}

print "Total sum: $totalsum\n";

# second part
my $total_space_used = $file_sizes{"/"};
my $memory_size = 70000000;
my $memory_available = $memory_size - $total_space_used;
my $memory_needed = 30000000;
my $free_up_amount = $memory_needed - $memory_available;

# this is updated
my $smallest_directory = $memory_size;

foreach my $path (sort keys %file_sizes) {
  my $value = $file_sizes{$path};
  if ($value >= $free_up_amount && $value < $smallest_directory) {
    $smallest_directory = $value;
  }
}

print "Smallest overflow: $smallest_directory\n";
