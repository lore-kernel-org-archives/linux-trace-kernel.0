Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07882DBF75;
	Tue, 11 Aug 2026 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410272; cv=none; b=L13VA9AsLCI4HTMEf2EvY+vUDRRrZWqnPUUZkh41s9G0PiTpdUbD4MYBVImHkk85jASaCld/kMtBsLuB3ygzhq2+T51zlQtk3BGp0y5ZD71NDdPlmtRJO1de+mSDW8ZuJvvODwZLybNoWpEE3wy5hbAHlWVkgiMGXE1qig8SqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410272; c=relaxed/simple;
	bh=Vu3SISkXgVnx90utBfaey/Sv5qkZQVeUnOPfIfZeGgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHa6w4Lf/ed4RlLpMDhOZPA9Skr3wjgWEnRJQTtxeVnoQ+Oy3xK6eEMuog71oPNcvq/7uaTqdC8HXCfYPUxX95cNDl99H/FKibMqPgxWpuEmW9YM3guvi7rHAmqRqwbxguRJcctgKbirhzWsMzJTX2oc/tsP143oXRDOn6rTKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 8D1351C0D44;
	Tue, 11 Aug 2026 01:04:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 04BFD20025;
	Tue, 11 Aug 2026 01:04:26 +0000 (UTC)
Date: Mon, 10 Aug 2026 21:04:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTLA changes for 7.3
Message-ID: <20260810210425.61435b0b@robin>
In-Reply-To: <20260805151055.870722-1-tglozar@redhat.com>
References: <20260805151055.870722-1-tglozar@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 04BFD20025
X-Stat-Signature: sri6xtsmh8q71rtnqdif84a4118d96to
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/9wlOgA4yps7Q1Q78spbH9ZvaJwdlGrmk=
X-HE-Tag: 1786410266-243030
X-HE-Meta: U2FsdGVkX18DbqV41LC20mQ5jLwTiV+fIpADHensa+RK3PwFmmxJrrjiQ5mmneGWGiM8zjdU5XkB/SqGrd/T+rLIeNlJP1sDz3GPvutf+KCGVT6jIXexCIUeMh4rdSJNl/aVCDgZSkSEfnEl89ehw2GFUp9feb/OPhmygAupErKQFgxsiXkDT8qe5xtHniBZbCfoCVtvu4kvP6t9MDOgXfrFXiCVBtWaevJ1RDRYw0Ryepog2xaWZOLPLyY843+qhccEe9t5rKs4DjNOwZ/C5/zyfffMs9rzfwZ84PVgEZK/Zl/JYq+tmKf6VzFKZNO1jDTrBIAlrEtVeo3kbCooImtWI//5pdFKpDLc8oMGVvvHmlOnFoSypw==

On Wed,  5 Aug 2026 17:10:55 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> Steven,
> 
> The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:
> 
>   Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-v7.3
> 
> for you to fetch changes up to 0ad45018ace734e3a21c8b15280df65b429135d1:
> 
>   rtla/cli: Unify and improve handling of invalid option arguments (2026-08-05 10:14:40 +0200)

I just tested this on my VM and have the following results from "make check":

Auto-detecting system features:
...                           libtraceevent: [ on  ]
...                              libtracefs: [ on  ]
...                             libcpupower: [ on  ]
...                                libcheck: [ OFF ]
...                                  libbpf: [ OFF ]
...                         clang-bpf-co-re: [ on  ]
...                       bpftool-skeletons: [ on  ]

libcheck is missing, building without unit tests support.
Please install check-devel/check
libbpf is missing, building without BPF skeleton support.
Please install libbpf-dev/libbpf-devel
[..]
tests/timerlat.t .. 
1..75
[..]
not ok 20 - top verify -c/--cpus
# Output match failed: "^Affinity of threads: 0$"
# Affinity of threads:
# Timer Latency
# 0 00:00:04   |	  IRQ Timer Latency (us)	|	  Thread Timer Latency (us)	 |    Ret user Timer Latency (us)
# CPU COUNT      |      cur	min	  avg	    max |      cur	 min	   avg	     max |	cur	  min	    avg	      max
# 0 #2	       |       72	 70	   71	     72 |      128	 128	   128	     129 |	154	  154	    154	      154
# ---------------|----------------------------------------|----------------------------------------|---------------------------------------
# ALL #2	    e0 |		 70	   71	     72 |		 128	   128	     129 |		  154	    154	      154
# timerlat hit stop tracing
# ## CPU 0 hit stop tracing, analyzing it ##
# IRQ handler delay:		      (exit from idle)	    58.28 us (45.18 %)
# IRQ latency:						    72.60 us
# Timerlat IRQ duration:				    32.63 us (25.29 %)
# Blocking thread:					    22.43 us (17.39 %)
# swapper/0:0			    22.43 us
# ------------------------------------------------------------------------
# Thread latency:					   129.00 us (100%)
# 
# Max timerlat IRQ latency from idle: 72.60 us in cpu 0
#
# exit code 2
not ok 21 - hist verify -c/--cpus
# Output match failed: "^Affinity of threads: 0$"
# Affinity of threads:
# # RTLA timerlat histogram
# # Time unit is microseconds (us)
# # Duration:   0 00:00:03
# Index	IRQ-000	  Thr-000   Usr-000
# 80	      1		0	  0
# 81	      1		0	  0
# 139	      0		2	  0
# 165	      0		0	  1
# over:	      0		0	  0
# count:	      2		2	  1
# min:	     80	      139	165
# avg:	     80	      139	165
# max:	     81	      139	165
# ALL:	    IRQ	      Thr	Usr
# count:	      2		2	  1
# min:	     80	      139	165
# avg:	     80	      139	165
# max:	     81	      139	165
# timerlat hit stop tracing
# ## CPU 0 hit stop tracing, analyzing it ##
# IRQ handler delay:		      (exit from idle)	    67.05 us (48.08 %)
# IRQ latency:						    81.97 us
# Timerlat IRQ duration:				    33.38 us (23.94 %)
# Blocking thread:					    22.95 us (16.46 %)
# swapper/0:0			    22.95 us
# ------------------------------------------------------------------------
# Thread latency:					   139.45 us (100%)
# 
# Max timerlat IRQ latency from idle: 81.97 us in cpu 0
#
# exit code 2
ok 22 - top verify -H/--house-keeping
ok 23 - hist verify -H/--house-keeping
ok 24 - top verify -k/--kernel-threads
ok 25 - hist verify -k/--kernel-threads
not ok 26 - top verify -u/--user-threads
# Output match failed: "0 kernel threads, 1 user threads"
# 0 kernel threads, 0 user threads
# Timer Latency
# 0 00:00:04   |	  IRQ Timer Latency (us)	|	  Thread Timer Latency (us)	 |    Ret user Timer Latency (us)
# CPU COUNT      |      cur	min	  avg	    max |      cur	 min	   avg	     max |	cur	  min	    avg	      max
# 0 #2	       |       90	 78	   84	     90 |      147	 136	   141	     147 |	163	  163	    163	      163
# ---------------|----------------------------------------|----------------------------------------|---------------------------------------
# ALL #2	    e0 |		 78	   84	     90 |		 136	   141	     147 |		  163	    163	      163
# timerlat hit stop tracing
# ## CPU 0 hit stop tracing, analyzing it ##
# IRQ handler delay:		      (exit from idle)	    75.58 us (51.26 %)
# IRQ latency:						    90.24 us
# Timerlat IRQ duration:				    33.32 us (22.60 %)
# Blocking thread:					    23.06 us (15.64 %)
# swapper/0:0			    23.06 us
# ------------------------------------------------------------------------
# Thread latency:					   147.46 us (100%)
# 
# Max timerlat IRQ latency from idle: 90.24 us in cpu 0
#
# exit code 2
not ok 27 - hist verify -u/--user-threads
# Output match failed: "0 kernel threads, 1 user threads"
# 0 kernel threads, 0 user threads
# # RTLA timerlat histogram
# # Time unit is microseconds (us)
# # Duration:   0 00:00:05
# Index	IRQ-000	  Thr-000   Usr-000
# 75	      1		0	  0
# 83	      1		0	  0
# 133	      0		1	  0
# 140	      0		1	  0
# 160	      0		0	  1
# over:	      0		0	  0
# count:	      2		2	  1
# min:	     75	      133	160
# avg:	     79	      136	160
# max:	     83	      140	160
# ALL:	    IRQ	      Thr	Usr
# count:	      2		2	  1
# min:	     75	      133	160
# avg:	     79	      136	160
# max:	     83	      140	160
# timerlat hit stop tracing
# ## CPU 0 hit stop tracing, analyzing it ##
# IRQ handler delay:		      (exit from idle)	    68.78 us (48.91 %)
# IRQ latency:						    83.35 us
# Timerlat IRQ duration:				    33.13 us (23.56 %)
# Blocking thread:					    22.89 us (16.28 %)
# swapper/0:0			    22.89 us
# ------------------------------------------------------------------------
# Thread latency:					   140.62 us (100%)
# 
# Max timerlat IRQ latency from idle: 83.35 us in cpu 0
#
# exit code 2
[..]

-- Steve
