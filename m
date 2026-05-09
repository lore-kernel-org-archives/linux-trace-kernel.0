Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9806244667
	for <linux-trace-kernel@vger.kernel.org>; Sat,  9 May 2026 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290173; cv=none; b=Dy/AHlkX62iexk7ZgG/m2jLe/aF2n49hqul8DurDh/v6ZOETRQjJF5ZA2Gj4uMTkdH1Y5qTU7ETV2pEI0ZE2L9rL28rkiG264LNuTv2JIiV3BImoZNhmhy6atd2dN5It5l+eI9+Ny7XpSxPoUfl/AinMkOwc++FtD00LJ1d1wpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290173; c=relaxed/simple;
	bh=i9QJ5WVSJdg5uQkuaetOnTEwzu0MFHwRbyFFAWZvYmo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mYZWgK6M4ec0M8uUF5tP2JZPybV2n3yjYIXhNBSqCQXjHbALPompFC5oInn0B1BlcpuRA57cjjM3uqUoyuS7KJYmK1RDXseX0GRg20R7CVy8QvDlnBrWjRKM1Rt91Nqdz4vDsLyhpnv4zER+3Nf2lm9ozOaG0+vo3SpN9ACPK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bTFXSijB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bTFXSijB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD81EC2BCB0;
	Sat,  9 May 2026 01:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778290173;
	bh=i9QJ5WVSJdg5uQkuaetOnTEwzu0MFHwRbyFFAWZvYmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bTFXSijBCGrOC3TaP7CWdWKJavw7s7CgBpYDB5evLFALWV6CljGRhEEZyhD6COQML
	 g3xSfSoD34Z2RuSPnk4KaALCiQMN3zblF6+jqNgJwNrDr27x0zNgJxyoT8BsbUjHy9
	 03zW0zcPgYhT1wVE4102cmwRiVKpDK3obixatNGk=
Date: Fri, 8 May 2026 18:29:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "qiwu.chen" <qiwuchen55@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
 david@kernel.org, mhocko@kernel.org, willy@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, "qiwu.chen"
 <qiwu.chen@transsion.com>
Subject: Re: [PATCH v2] mm: vmscan: rework lru_shrink and write_folio
 tracepoints
Message-Id: <20260508182932.ee1931dec680db80a8a8e660@linux-foundation.org>
In-Reply-To: <20260506083652.100160-1-qiwu.chen@transsion.com>
References: <20260506083652.100160-1-qiwu.chen@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 May 2026 16:36:52 +0800 "qiwu.chen" <qiwuchen55@gmail.com> wrote:

> Currently, reclaim_flags always contains RECLAIM_WB_ASYNC in lru_shrink
> tracepoints since commit 41ac1999c3e35 ("mm: vmscan: do not stall on
> writeback during memory compaction"), which is useless for debugging
> memory pressure issues. Other RECLAIM_WB_* flags are not used anywhere
> else, so they can be directly removed.
> This patch reworks the lru_shrink and write_folio tracepoints for better
> correlation and analysis:
>  - traces each folio lru type instead of reclaim_flags.
>  - traces each lru_shrink with reason.
>  - remove the printing of the unnecessary PFN for mm_vmscan_write_folio.

Applying this to 7.1-rc1, my x86_64 allmodconfig blew up.



In file included from ./include/trace/define_trace.h:132,
                 from ./include/trace/events/vmscan.h:602,
                 from mm/vmscan.c:72:
./include/trace/events/vmscan.h: In function 'trace_raw_output_mm_vmscan_write_folio':
./include/trace/events/vmscan.h:358:19: error: format '%p' expects argument of type 'void *', but argument 3 has type 'long unsigned int' [-Werror=format=]
  358 |         TP_printk("folio=%p lru=%s",
      |                   ^~~~~~~~~~~~~~~~~
./include/trace/trace_events.h:219:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
  219 |         trace_event_printf(iter, print);                                \
      |                                  ^~~~~
./include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
   45 |                              PARAMS(print));                   \
      |                              ^~~~~~
./include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
  342 | TRACE_EVENT(mm_vmscan_write_folio,
      | ^~~~~~~~~~~
./include/trace/events/vmscan.h:358:9: note: in expansion of macro 'TP_printk'
  358 |         TP_printk("folio=%p lru=%s",
      |         ^~~~~~~~~
In file included from ./include/trace/trace_events.h:256:
./include/trace/events/vmscan.h:358:27: note: format string is defined here
  358 |         TP_printk("folio=%p lru=%s",
      |                          ~^
      |                           |
      |                           void *
      |                          %ld
./include/trace/events/vmscan.h: In function 'do_trace_event_raw_event_mm_vmscan_write_folio':
./include/trace/events/vmscan.h:354:32: error: assignment to 'long unsigned int' from 'struct folio *' makes integer from pointer without a cast [-Wint-conversion]
  354 |                 __entry->folio = folio;
      |                                ^
./include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
  427 |         { assign; }                                                     \
      |           ^~~~~~
./include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
  435 |                       PARAMS(assign), PARAMS(print))                    \
      |                       ^~~~~~
./include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ^~~~~~~~~~~~~~~~~~~
./include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
   44 |                              PARAMS(assign),                   \
      |                              ^~~~~~
./include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
  342 | TRACE_EVENT(mm_vmscan_write_folio,
      | ^~~~~~~~~~~
./include/trace/events/vmscan.h:353:9: note: in expansion of macro 'TP_fast_assign'
  353 |         TP_fast_assign(
      |         ^~~~~~~~~~~~~~
In file included from ./include/trace/define_trace.h:133:
./include/trace/events/vmscan.h: In function 'do_perf_trace_mm_vmscan_write_folio':
./include/trace/events/vmscan.h:354:32: error: assignment to 'long unsigned int' from 'struct folio *' makes integer from pointer without a cast [-Wint-conversion]
  354 |                 __entry->folio = folio;
      |                                ^
./include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
   51 |         { assign; }                                                     \
      |           ^~~~~~
./include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
   67 |                       PARAMS(assign), PARAMS(print))                    \
      |                       ^~~~~~
./include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
   40 |         DECLARE_EVENT_CLASS(name,                              \
      |         ^~~~~~~~~~~~~~~~~~~
./include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
   44 |                              PARAMS(assign),                   \
      |                              ^~~~~~
./include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
  342 | TRACE_EVENT(mm_vmscan_write_folio,
      | ^~~~~~~~~~~
./include/trace/events/vmscan.h:353:9: note: in expansion of macro 'TP_fast_assign'
  353 |         TP_fast_assign(
      |         ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:289: mm/vmscan.o] Error 1
make[2]: *** [scripts/Makefile.build:548: mm] Error 2
make[1]: *** [/usr/src/25/Makefile:2141: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

