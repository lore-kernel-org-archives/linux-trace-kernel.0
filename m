Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0317A305;
	Wed, 10 Jun 2026 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052687; cv=none; b=VeLPNFEOPQqXcXmQR9eHftovLc2AcfmEtM4TBNCzh+fOfU65A4fKSw4QnHJoB9Ux+tqMONzSV1yOklIAE9TNTfl9HKUojOB3oWJPDGOxdNONkV7KO4RBbETRmEtOChY/T76WhNOroXDPVtbRWT4eshTEWdc7vUX+kEWUcR5mqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052687; c=relaxed/simple;
	bh=hHSweqaoPPOWP//CiRXcgp6ysK37O1r6QEAl6tA6cSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gddaDY3ePmUwINdZILnNKwuGuvuH2PUF4IIWLPB5gWn3wuN9k+MMW6ZjXlwDVbBXCnsyHOAWJpfumwJr7v9RIuASufb235lYx4v9fmkuAryp5RRrc9+uHLKMqR/yNHa30llxhaB28MsMQQaIKliOGkjYy0NB/BvvEVVFaCL3KYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh29NEbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh29NEbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14041F00893;
	Wed, 10 Jun 2026 00:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781052685;
	bh=AknOC9ftrQ9npWsX4G287ronaobFlPP7dg7D/271fCg=;
	h=From:To:Cc:Subject:Date;
	b=Kh29NEbWMMf5Dwxam8iyR8o0632/X5Fn4bfelwOtb9BkK11MH65DqlmD0pqOmMqmF
	 PZSo+WesGN+gUdNj6PQ5kwR347apZtnzxRJqiDChzymX97AIfxbbdsKVAkV6tjFUts
	 eccMq3EBPzzvaiLzw1GWYOpA1Qxopto93ZvaUoEb7rgQ9WIeCT44heH9pxv88JuLFF
	 lBUcFJudrS3jIJp1gll1aVlEDwESrUhRQic2HW5hFghoC7zZFihXboBIvlHu3tq9S0
	 uUvXdQm8NaMjWpEV1rFEmx0cZLfOxK97OEwzN60rHaZ0tkbAMyPilMdpJ/2kONOSyw
	 jHbusxyGvOtaw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 0/7] tracing/probes: Add more typecast features
Date: Wed, 10 Jun 2026 09:51:21 +0900
Message-ID: <178105268094.21760.13668249930524377840.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 2nd version of series to introduce more typecast features
to probe events. The previous version is here:

 https://lore.kernel.org/all/178092865666.163648.10457567771536160909.stgit@devnote2/

In this version, I fixed various problems Sashiko reviewed and add
a fix of sample code. Also drop +CPU/PCPU() and introduce this_cpu_read().


Steve introduced BTF typecast feature for eprobe[1].
This series extends it and add more options:

1. Expanding BTF typecast to kprobe and fprobe.
   (currently only function entry/exit)

2. Introduce container_of like typecast. This adds a "assigned
   member" option to the typecast.

   (STRUCT,MEMBER)VAR->ANOTHER_MEMBER

   This casts VAR to STRUCT type but the VAR is as the address
   of STRUCT.MEMBER. In C, it is:

   container_of(VAR, STRUCT, MEMBER)->ANOTHER_MEMBER

3. Support nested typecast, e.g.

   (STRUCT)((STRUCT2)VAR->MEMBER2)->MEMBER

   the nest level must be smaller than 3.

4. Add $current variable to point "current" task_struct.
   This is useful with typecast, e.g.

   (task_struct)$current->pid

5. per-cpu dereference support.

   Intrdouce this_cpu_read(VAR) and this_cpu_ptr(VAR) to
   access per-cpu data on the current CPU (accessing other CPU
   data is not stable, because it can be changed.)

   You can access the member of per-cpu data structure using
   typecast like:

   (STRUCT)this_cpu_ptr(VAR)->MEMBER


And added a test script to test part of them.

[1] https://lore.kernel.org/all/20260601130746.2139d926@gandalf.local.home/


---

Masami Hiramatsu (Google) (7):
      tracing/events: Fix to check the simple_tsk_fn creation
      tracing/probes: Support typecast for various probe events
      tracing/probes: Support nested typecast
      tracing/probes: Support field specifier option for typecast
      tracing/probes: Add $current variable support
      tracing/probes: Add this_cpu_read() and this_cpu_ptr() dereference method to fetcharg
      tracing/probes: Add a new testcase for BTF typecasts


 Documentation/trace/eprobetrace.rst                |   10 
 Documentation/trace/fprobetrace.rst                |   10 
 Documentation/trace/kprobetrace.rst                |   11 +
 kernel/trace/trace.c                               |    6 
 kernel/trace/trace_probe.c                         |  404 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   18 +
 kernel/trace/trace_probe_tmpl.h                    |   33 +-
 samples/trace_events/trace-events-sample.c         |   56 ++-
 samples/trace_events/trace-events-sample.h         |   34 ++
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 +++
 10 files changed, 509 insertions(+), 124 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
