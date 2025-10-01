Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201949620;
	Wed,  1 Oct 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329018; cv=none; b=fl7q/zsLuioe/HOW4iV11oeb5MKXFMKsg6xaWI3Ju1Jyhm7KYoNHopVI5wKBmm394Gu63K0r069VYPHfB7rhOU16TjWxtI75+qcx1mzO+FhhsEO2v0+piagNCQDnr8iVgRJQ+AJ7zcRTkGILhUedsdhmUv44I9ccIqGH8t9apvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329018; c=relaxed/simple;
	bh=T2lPMlHjBYAZPQbbcozUq1XCXnjWfG+6KdtxqqLS5K8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCE7U+dELLusWLfBVnbE7f/GL8Shqa2jalOj+P42mCdL3eCR1nGSRYyhaQInvHU4fiuDVteSVvTuLDX1/eeh9KXOOV5m0wg+KzbAuoSa3lY2PMQoY9eepVNJiaAS3MYxAo7CjlIDSPJElHPcg4pZx3HQoiihspK6b9Zim+/lZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 31E6E11B230;
	Wed,  1 Oct 2025 14:30:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 01C9C80009;
	Wed,  1 Oct 2025 14:30:11 +0000 (UTC)
Date: Wed, 1 Oct 2025 10:31:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: chenyuan_fl@163.com, mhiramat@kernel.org, bigeasy@linutronix.de,
 chenyuan@kylinos.cn, john.ogness@linutronix.de,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-ID: <20251001103149.2d52d03f@gandalf.local.home>
In-Reply-To: <20251001123200.GN4067720@noisy.programming.kicks-ass.net>
References: <20251001003707.3eaf9ad062d5cad96f49b9ba@kernel.org>
	<20251001022025.44626-1-chenyuan_fl@163.com>
	<20251001123200.GN4067720@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8b7qyexcz4ufrgntfonswjidaugw7uni
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 01C9C80009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/O2eYo98dLMe9XO+5oalOG54NXO+Xl11g=
X-HE-Tag: 1759329011-379951
X-HE-Meta: U2FsdGVkX1+JotVA9HyKXqq3WYdBOF5KBykD7Ex9bOZJYMgom0OvJWajolCo2hblSz7Co05pSEpE4dimNJ8qp+rES/fkMB8PBIEtFn3eU+ci+INLnECeUabXlbd2B6QosFbLaRXB46wZXqkTixPBvJLQZZnrN7BHbbz0zWkiz1F4hfa41tevLStU+5rFMz4Nu0DGbx28Lkxib4koiSgOiYe4Ss3VkgZa11A/qwuQQvpANVNqpJ62aJAAHwZVB5MGTR4bFjD9oKtTSAYpwEuYWSIgdNHincnLMXEGBh9EwDmgVy0nhSyoDQAUgMed1IjFnreda4IsJALNsH6aXpohpfcJ561mbbzIkrVWU1syMPj1K1Z53kUE1/E3K/ZWydZ/Kflg/nJbHfVdKWYEuztgjg==

On Wed, 1 Oct 2025 14:32:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Anyway, patch looks reasonable now. Rest is up to Steve, this is his
> code.

Actually, it's Masami's ;-)  And it's up to him.

-- Steve
