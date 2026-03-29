Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44F313552;
	Sun, 29 Mar 2026 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801333; cv=none; b=fAwTRQhO5/VnUwOTUEPb/XqY6G17jIeJSDCRw5fIfvtmbND2pLZ4sYLX1x4AhVQJaktKsA0BJaYPQJHoyg982hq6ixjW3yURoMGdQss36T0aOcB6m7pdgwjmLN8tBTuCsmifhWhyQoLf2MadyLrFKN1grGDSG6aqEU3QPGI7l5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801333; c=relaxed/simple;
	bh=CpBhkj/W0kz7vKawTX+Ucu4qBGtniA+jGgXJrWBmgjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfUcyLzaxAvGw8Tj3bZiiQ+xKh7xECP3RDeZy3Xvp2OukRonftevUgZ5I+e6/S3ZGvbhP3CzoolaCnke0EpHKjX3dnJ3ayict5RsJ0MDNnNAYAblHckyvZpTlMfYse8SsWXOaxbM6tYDYIucSJNlrhj8TZAClm0PbvhYiI3N1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 3B98058FD9;
	Sun, 29 Mar 2026 16:22:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 82D332F;
	Sun, 29 Mar 2026 16:22:03 +0000 (UTC)
Date: Sun, 29 Mar 2026 12:22:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTLA changes for v7.1
Message-ID: <20260329122202.65a8b575@robin>
In-Reply-To: <20260327150237.405973-1-tglozar@redhat.com>
References: <20260327150237.405973-1-tglozar@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ttbyph71zat1osz7omxd1jrog8mfc7g1
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 82D332F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+6ZB5aiIstgnHT1mkbwunl7EVygtSACw8=
X-HE-Tag: 1774801323-940897
X-HE-Meta: U2FsdGVkX18pZN4YAl9vizmx6QL6pTAIWTuuNHWePIHTCuLwTCHaqAhz61vLX63NYEVrm8rQ+URZu/YZBZy/0r/xQjNwqJq4/syYFpHPmYKHlSzYsyx+JMlRK5E6MltnuQK4k5Q7iUrE1+s2mFq+fKItMMQimYFWbnprXhDleTtV1a143K/JnICTVinau0/HlkyKXUVZU0hjXVJLvkQ9KvX0U7TOHCGH4sh0XqsvW+UqFwAehfuWCtJkSr4NAoqjJOYF6Z+A41LtR/FC1tJJrTHd2/P1rCSP18vMQsXvQwRPxj+dVnbM2jFg7w0xFrA1nZZXt3DVi80tixaKHmpIlfycjmbZNYNzuQzp29W6FCEXNwzY+5efsw==

On Fri, 27 Mar 2026 16:02:37 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> Steven,
> 
> please pull the following changes for RTLA (more info in tag description).

I can pull this but I just noticed that starting with 7.0-rc1, it fails
to build without libbpf:

Auto-detecting system features:
...                           libtraceevent: [ on  ]
...                              libtracefs: [ on  ]
...                             libcpupower: [ OFF ]
...                                  libbpf: [ OFF ]
...                         clang-bpf-co-re: [ on  ]
...                       bpftool-skeletons: [ OFF ]

libcpupower is missing, building without --deepest-idle-state support.
Please install libcpupower-dev/kernel-tools-libs-devel
libbpf is missing, building without BPF skeleton support.
Please install libbpf-dev/libbpf-devel
bpftool is missing or not supporting skeletons, building without BPF skeleton support.
Please install bpftool
make -f /work/git/linux-trace.git/tools/build/Makefile.build dir=. obj=rtla
make[1]: Entering directory '/work/git/linux-trace.git/tools/tracing/rtla'
make[2]: Entering directory '/work/git/linux-trace.git/tools/tracing/rtla'
  CC      /work/git/linux-trace.git/tools/tracing/rtla/src/trace.o
  CC      /work/git/linux-trace.git/tools/tracing/rtla/src/utils.o
  CC      /work/git/linux-trace.git/tools/tracing/rtla/src/actions.o
  CC      /work/git/linux-trace.git/tools/tracing/rtla/src/common.o
  CC      /work/git/linux-trace.git/tools/tracing/rtla/src/osnoise.o
  CC      /work/git/linux-trace.git/tools/tracing/rtla/src/osnoise_top.o
  CC      /work/git/linux-trace.git/tools/tracing/rtla/src/osnoise_hist.o
  CC      /work/git/linux-trace.git/tools/tracing/rtla/src/timerlat.o
In file included from src/timerlat.c:18:
src/timerlat_bpf.h:15:10: fatal error: bpf/libbpf.h: No such file or directory
   15 | #include <bpf/libbpf.h>
      |          ^~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [/work/git/linux-trace.git/tools/build/Makefile.build:94: /work/git/linux-trace.git/tools/tracing/rtla/src/timerlat.o] Error 1
make[2]: Leaving directory '/work/git/linux-trace.git/tools/tracing/rtla'
make[1]: *** [/work/git/linux-trace.git/tools/build/Makefile.build:156: src] Error 2
make[1]: Leaving directory '/work/git/linux-trace.git/tools/tracing/rtla'
make: *** [Makefile:104: /work/git/linux-trace.git/tools/tracing/rtla/rtla-in.o] Error 2

That should probably be fixed on top of v7.0-rcX so that it is not
broken in 7.0.

-- Steve


> 
> Thanks,
> Tomas
> 
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:
> 
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-v7.1
> 
> for you to fetch changes up to 82374995b63d2de21414163828a32d52610dcaf2:
> 
>   Documentation/rtla: Document SIGINT behavior (2026-03-27 10:58:30 +0100)

