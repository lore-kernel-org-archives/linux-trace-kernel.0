Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2AA11CBA;
	Mon, 14 Jul 2025 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503574; cv=none; b=UYsFxr25xjluu8yJuyJs+XToJAyeMibNtE7/a08ZMRDSwDludc399fTmJDl1nIFL8s8p6B1YetwldmnNQqT9EvJkCeGMGFYLo3t+YJsBK/pWZ+HVffpoSDXyntTJOQKepmhldRKXa4p8ha6wK6182FW0DviW5BH18Fbuhbwrwso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503574; c=relaxed/simple;
	bh=y8Zyu954SfhFDdcRBZhN33yK86h816ltT5DQDQhAZ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoaJEWakFCTE3vhyWMiRCCsHZM+OCPYCSZEKHM30fVkdoOnaetA1aY6Zeyb07ELZG012QqDto2cpX/ljhsymF/eKKaPJl1x9mO6TM5RjAPjofl+Eos0OgJOE7tdbM4aaFiPg/BTfWytVmAuIXnyTSxO1fBPBus4xYE+ptiN2218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 32B055690E;
	Mon, 14 Jul 2025 14:32:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 7BE4E2000D;
	Mon, 14 Jul 2025 14:32:43 +0000 (UTC)
Date: Mon, 14 Jul 2025 10:32:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250714103248.0673aba8@batman.local.home>
In-Reply-To: <20250714231412.73e511c5c9524cde5d475770@kernel.org>
References: <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
	<175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<20250709131107.397a3278@batman.local.home>
	<20250711143703.60a1a9a9f31a45f2000eec9d@kernel.org>
	<20250711120322.4ddb9b39@batman.local.home>
	<20250712204524.13ece418f90ea66d4bd0e598@kernel.org>
	<20250712103732.79c7b9e1@batman.local.home>
	<20250714231412.73e511c5c9524cde5d475770@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7BE4E2000D
X-Stat-Signature: djbo74g3ejbp1ccpjbr5jcx51nmsdnrz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Z2Ik69s9g68g35xz+FYMx443Wo7Gyzi4=
X-HE-Tag: 1752503563-818362
X-HE-Meta: U2FsdGVkX1/vDIkwvVBYX0cCb3zLhGDtCX1e0C1WzdzIZY9HE3qann50Q40/Pmo3qC3Hslah5Qm0Zwn337LfCoCblCB+GVgh+0HoLBVo/mIC/qm0t87ki/4jN6HBXWxtMEHu6jlAtK7rhATeIe28NKP4/dzT7IdZF6cvqyl3zScHGtKMLsSOGf/eYbm80OzNhohshS31HEKtUvRaN48X/o/dw4350/gVw/b0EFmTrgkCd/ILLLSiDJBpJPwPHV1qL5l7sgielu7GQ13K8VgwlLAyA38q/VaVYCx1yla1iclOLs6byDgGXIWu7n5CFPpbYC0xmasakLFpX8k5ykyYNyQrYeNr5GOY

On Mon, 14 Jul 2025 23:14:12 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm, is this called unless loading modules? It seems that the
> function is only kicked from trace_module_notify() -> trace_module_add_evals() -> trace_insert_eval_map() (but if mod has any trace_evals)

As it has to work on non-module events, yes it is called.

late_init_syscall() -> trace_eval_init() -> queue_work(eval_map_work)

  eval_map_work_func() -> trace_insert_eval_map() -> ...

-- Steve

