Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D04A06
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606589; cv=none; b=NJHyH4alcMZFXZa973cYRI54hzdsJzd4f4Lfc+rBOSkAxwXUl1JnNYhYhNgeaJKpBNCaEPMSEFGHaB6/DFPOIDVykpuxqoOVbeovnUHTySixMwee4Hrg8ONxXfU6XqXvI2CUy2O5gDKSzQ2GW6PSjmB6GH1buSnJM/ezzPqmmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606589; c=relaxed/simple;
	bh=yK9sXPWVgFxq090roxPVExH2KmktNeD8jxmsPQ7+tMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pa86wmpk8Tm+I7k7l2DQtS6RDT1Na4DdHjoPMK4CZ0XhNlxbC1QJoYEGxecimYYC1L6wrIJ5o5KDGPMSPWTWBuiiMZNrmn1IzjJMcUBpSNmfMBOMYUUa4JK+9xBFfrt2X1kZi0ks+td0fogk3etPRnFAU9XCK7MS17f6QXce9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A02C4CECC;
	Fri, 11 Oct 2024 00:29:48 +0000 (UTC)
Date: Thu, 10 Oct 2024 20:29:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: furkanonder <furkanonder@protonmail.com>
Cc: "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH] tools/rtla: Enhance Error Handling and Readability for
 timerlat
Message-ID: <20241010202956.5aa773a7@gandalf.local.home>
In-Reply-To: <HAxOlk1o3vhrAUlyVMtrSLGP39PFS1TLfGT9C9pB6cXgQpGB_fiNeGSuWS_4-4zeMxunluuBnkc4Y-k_c0qrlstVpYQvgfkJN2p_VnfMO-k=@protonmail.com>
References: <HAxOlk1o3vhrAUlyVMtrSLGP39PFS1TLfGT9C9pB6cXgQpGB_fiNeGSuWS_4-4zeMxunluuBnkc4Y-k_c0qrlstVpYQvgfkJN2p_VnfMO-k=@protonmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Tomas,

Can you review this patch?

Thanks,

-- Steve


On Sat, 05 Oct 2024 17:20:37 +0000
furkanonder <furkanonder@protonmail.com> wrote:

> The enhancements made to timerlat_load.py focus on improving error
> handling, readability, and overall user experience. These changes aim to
> make the script more robust and easier to maintain while providing clearer
> feedback to users. Key modifications include:
> 
> Type Declaration in Argument Parsing
> Added type declarations for command-line arguments in the argument parser.
> This removes the need for manual type checks later in the code, improving
> clarity and safety.
> 
> String Formatting
> Replaced string concatenation with an f-string to enhancing readability
> and conciseness.
> 
> Enhanced Exception Handling and Consistent Error Reporting
> Specific exceptions are now caught and printed with clearer messages,
> providing context for errors when opening file descriptors. Added
> exception handling for the data file descriptor opening to ensure
> uniformity across the script.
> 
>   Before:
>      $ sudo python timerlat_load.py 122
>      Error setting affinity
>   After:
>      $ sudo python timerlat_load.py 122
>      Error setting affinity: [Errno 22] Invalid argument
> 
>   Before:
>      $ sudo python timerlat_load.py 1 -p 950
>      Error setting priority
>   After:
>      $ sudo python timerlat_load.py 1 -p 950
>      Error setting priority: [Errno 22] Invalid argument
> 
>   Before:
>      $ python timerlat_load.py 1
>      Error opening timerlat fd, did you run timerlat -U?
>   After:
>      $ python timerlat_load.py 1
>      Permission denied. Please check your access rights.
> 
> Changes for the read Infinite Loop
> The original generic exception clause has been replaced with more
> specific exception types to provide clearer feedback on errors.
> 
> Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
> ---
>  tools/tracing/rtla/sample/timerlat_load.py | 56 +++++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtla/sample/timerlat_load.py
> index 8cc5eb2d2e69..a819c3588073 100644
> --- a/tools/tracing/rtla/sample/timerlat_load.py
> +++ b/tools/tracing/rtla/sample/timerlat_load.py
> @@ -25,50 +25,54 @@ import sys
>  import os
> 
>  parser = argparse.ArgumentParser(description='user-space timerlat thread in Python')
> -parser.add_argument("cpu", help='CPU to run timerlat thread')
> -parser.add_argument("-p", "--prio", help='FIFO priority')
> -
> +parser.add_argument("cpu", type=int, help='CPU to run timerlat thread')
> +parser.add_argument("-p", "--prio", type=int, help='FIFO priority')
>  args = parser.parse_args()
> 
>  try:
> -    affinity_mask = { int(args.cpu) }
> -except:
> -    print("Invalid cpu: " + args.cpu)
> -    exit(1)
> -
> -try:
> -    os.sched_setaffinity(0, affinity_mask);
> -except:
> -    print("Error setting affinity")
> -    exit(1)
> +    affinity_mask = {args.cpu}
> +    os.sched_setaffinity(0, affinity_mask)
> +except Exception as e:
> +    print(f"Error setting affinity: {e}")
> +    sys.exit(1)
> 
> -if (args.prio):
> +if args.prio:
>      try:
> -        param = os.sched_param(int(args.prio))
> +        param = os.sched_param(args.prio)
>          os.sched_setscheduler(0, os.SCHED_FIFO, param)
> -    except:
> -        print("Error setting priority")
> -        exit(1)
> +    except Exception as e:
> +        print(f"Error setting priority: {e}")
> +        sys.exit(1)
> 
>  try:
> -    timerlat_path = "/sys/kernel/tracing/osnoise/per_cpu/cpu" + args.cpu + "/timerlat_fd"
> +    timerlat_path = f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu}/timerlat_fd"
>      timerlat_fd = open(timerlat_path, 'r')
> -except:
> +except PermissionError:
> +    print("Permission denied. Please check your access rights.")
> +    sys.exit(1)
> +except OSError:
>      print("Error opening timerlat fd, did you run timerlat -U?")
> -    exit(1)
> +    sys.exit(1)
> 
>  try:
> -    data_fd = open("/dev/full", 'r');
> -except:
> -    print("Error opening data fd")
> +    data_fd = open("/dev/full", 'r')
> +except Exception as e:
> +    print(f"Error opening data fd: {e}")
> +    sys.exit(1)
> 
>  while True:
>      try:
>          timerlat_fd.read(1)
> -        data_fd.read(20*1024*1024)
> -    except:
> +        data_fd.read(20 * 1024 * 1024)
> +    except KeyboardInterrupt:
>          print("Leaving")
>          break
> +    except IOError as e:
> +        print(f"I/O error occurred: {e}")
> +        break
> +    except Exception as e:
> +        print(f"Unexpected error: {e}")
> +        break
> 
>  timerlat_fd.close()
>  data_fd.close()
> 
> --
> 2.46.2

