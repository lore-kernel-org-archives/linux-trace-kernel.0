Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649337A3D4;
	Thu, 30 Oct 2025 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793313; cv=none; b=mKp0dDkH+ryWHOfw2hS8Juzfb5HoRlDdekA/H5S84DFLJbjpTSBacjZVO5sAmknc1VFbosgXV4I34M6hxxjijtNnEpBxRgWT3rcjfZCcV19aewGIlmPfJscwkgcUDKZqAQ//9b3eJHT1R4QbNir76AWW0mL0luucT+VgALTNSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793313; c=relaxed/simple;
	bh=3J40deEdpHMA/CyI3moIIEYn6usFyZwtuLOaYv4VsQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U7C6Gk8mDlp8njqLMxpHIL5jbZtxM2PeOgvu/NdxolWi68odAfUiSG9LLI4+1Z9EHfQeEjITAMyk5Ddh16qxT6wAnAqU7lPZ+4yQFjn8kEDS8qO64Jxdv1ThUQZ9Q/JxJ8XhZn9DdNd8ggICLCTj5pkgolgMi47okNSLH6LM+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzKPYQJq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzKPYQJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC04C4CEF7;
	Thu, 30 Oct 2025 03:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761793313;
	bh=3J40deEdpHMA/CyI3moIIEYn6usFyZwtuLOaYv4VsQg=;
	h=From:To:Cc:Subject:Date:From;
	b=AzKPYQJq1+nUf6SD1liJn5Luz4JKw5AS2SgKc+g4azT4a9lyUNsewuEUMy8CVZqQL
	 5BWht0tNV73RzgOWgsRuVz33ZgMQHoYyYDYl/08NACs63MjwAnPTemi57jPIaE2Vsw
	 iDVFIHH55SlNQ9FmPR8TILUQZaVAfDec7JsdmZj56CRqbvauUdOdN5O8PJ8gxsALAf
	 bU7PIi0lhanWRF7dLNQgLQFAD/TzNUpLIrI7p9xfni4f/UsKpeOFsgna2a8kybdHf3
	 EjWseSRs/YNdRkHYeeX/0DgH8WObJyNzzGdfw83aYKc+1FyjVD4W+FFnEXd5uunYGM
	 tUkMJZU0Nd63g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Thu, 30 Oct 2025 12:01:48 +0900
Message-ID: <176179330871.957820.2367690308433599462.stgit@devnote2>
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

This series implements an option to show symbols in _text+OFFSET
format instead of symbol name in the function profiler.
This is the 6th version, the previous one is here;

https://lore.kernel.org/all/176114747153.315239.6863821259073466010.stgit@devnote2/

This version is rebased on top of linux-trace/for-next branch
and modify offset format to hex.

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing: Allow tracer to add more than 32 options
      tracing: Add an option to show symbols in _text+offset for function profiler


 kernel/trace/blktrace.c              |    6 +
 kernel/trace/ftrace.c                |   26 ++++++
 kernel/trace/trace.c                 |  154 +++++++++++++++++-----------------
 kernel/trace/trace.h                 |   40 +++++----
 kernel/trace/trace_events.c          |    4 -
 kernel/trace/trace_events_synth.c    |    2 
 kernel/trace/trace_fprobe.c          |    6 +
 kernel/trace/trace_functions_graph.c |   18 ++--
 kernel/trace/trace_irqsoff.c         |   30 +++----
 kernel/trace/trace_kdb.c             |    2 
 kernel/trace/trace_kprobe.c          |    6 +
 kernel/trace/trace_output.c          |   18 ++--
 kernel/trace/trace_sched_wakeup.c    |   24 +++--
 kernel/trace/trace_syscalls.c        |    4 -
 kernel/trace/trace_wprobe.c          |    2 
 15 files changed, 187 insertions(+), 155 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
