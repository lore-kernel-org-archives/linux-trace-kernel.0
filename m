Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14625228C;
	Wed, 17 Dec 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998413; cv=none; b=nxyI5hHGHGqQIqTeTQP2AkmDzYTz0S2nW9K3geZYnnYc0LD2HBGPWsnnOivHx/c1aIz3kxrYMl1rCKzdTh/npfVbUqINsUAdOsiy3KA872gTFC7U37WjklZABMypEo0yldqZ3YCFKAOnd6ii6x/XVV/TIpavCW1edHScDoUqWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998413; c=relaxed/simple;
	bh=ocLUpl3wFK1ZMS5TR7Bm+xXLxFSu2+wCSVjFjs1Bj0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROAd79CwAkzQCaQ7OPMA/q4NfrprKC6ChonpKi9FHHWJvnre+FVvJEsoLblWwtBSh9zu1Q8AMAz0OrtaOM/xNnRu23ES88HK1UrKmwyba6z0eCpzRSzuvfeW294qNdm/JJCUPlytWEPDuazSsUhJB/cHg7LoTWqZflhDELExtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 96BD28B79A;
	Wed, 17 Dec 2025 19:06:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 49E1C20032;
	Wed, 17 Dec 2025 19:06:40 +0000 (UTC)
Date: Wed, 17 Dec 2025 14:08:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Rogers <irogers@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Allow perf to read synthetic events
Message-ID: <20251217140816.23a8a1bc@gandalf.local.home>
In-Reply-To: <CAP-5=fUFZaDTEDytOVW_R-v+fys11ojuoCbs9c2UQqvxDYUxGg@mail.gmail.com>
References: <20251217113920.50b56246@gandalf.local.home>
	<CAP-5=fUFZaDTEDytOVW_R-v+fys11ojuoCbs9c2UQqvxDYUxGg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qtho7xynzp3ftwjenw6xce4qwowxaksb
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 49E1C20032
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+j6H2HWjzjQ9F47pkveouItVJb9wqD+IE=
X-HE-Tag: 1765998400-940074
X-HE-Meta: U2FsdGVkX1+vfazomHCj7uCgpgKgUW+69i7rD3+vFx4gYBxegbUb1oCGGEWVN/9VIPnoU1NGE6hm81FeGEaUvqVjocbG5vRS2DvIRcBosfNaqpBWdg0BvQFwm5gO2nR/JGLfDpDvkE/jIJXofnjBaJHR8laIrBfVZ3i5E05DumL4peFY3Kv/c5iZcBytRTPk87p9bP/pWw+UoXX26Q648nSdAPFvte4XB7AKyGYA0jgJcPJSN+u6GdoNM+jrLkeogw53cFO57bdPojvf2GuPsoC37wkVHqid9HEB69KnoF0ZlseVBboCObj6epcU44/i2QruKJW8xOIXHODgv34t8HPFOA1S/1D8

On Wed, 17 Dec 2025 10:58:25 -0800
Ian Rogers <irogers@google.com> wrote:

> This is great! Any chance of an example of using it? I'd like to add a test.

I tested it with:

  # trace-cmd sqlhist -e -n futex_wait select TIMESTAMP_DELTA_USECS as lat from sys_enter_futex as start join sys_exit_futex as end on start.common_pid = end.common_pid
  # perf record -e synthetic:futex_wait
  # perf script
            bash    1043 [002]    49.501707: synthetic:futex_wait: lat=8
     in:imuxsock     610 [005]    58.904344: synthetic:futex_wait: lat=27
   rs:main Q:Reg     612 [007]    58.904478: synthetic:futex_wait: lat=10847333
   rs:main Q:Reg     612 [007]    58.904507: synthetic:futex_wait: lat=6
              ls    1050 [004]    59.283561: synthetic:futex_wait: lat=8
       in:imklog     611 [004]    69.084959: synthetic:futex_wait: lat=55
   rs:main Q:Reg     612 [007]    69.085014: synthetic:futex_wait: lat=10180378
   rs:main Q:Reg     612 [007]    69.085041: synthetic:futex_wait: lat=5


But feel free to use any other synthetic event or perf command.

-- Steve
