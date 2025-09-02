Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB1208CA;
	Tue,  2 Sep 2025 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843227; cv=none; b=i/HOXidhKZLd4mr986RMtcPuQFNDFM5jmwUQErlK590Yup1YR2lpJss/aZPh5uXgP0+njo3mC2EHShc5pc7dvfEaDcHmfBEGiz2OlYaqM4U0URlQC75rKVdhpuXDLh1Uwj/WiEvJIedNQ25Eaw6PkUmLxe+nBLlrHUsLfb01Jh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843227; c=relaxed/simple;
	bh=KnqWnLCo0tk6ujCYTF8NKz66XleUs6Rt60ou8djh17Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6/dv5LqjR1gXq9AjrCz+s/Di7gpyrTmRnDnVSyYqGGas5WXXcK+6W9fUeaF5Zmt1Zl3bLa84jeYCLmrlq44GcKXR389Jg1nMwpWAhSpoTfwVds+PisfrDjAZ3eLWA8BFRW3ECvxjR8KzLK7LyM4v5rptwp20JY95Dkr/ew5ScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A1E12119B0B;
	Tue,  2 Sep 2025 20:00:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 07B6F2002D;
	Tue,  2 Sep 2025 20:00:21 +0000 (UTC)
Date: Tue, 2 Sep 2025 16:00:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Elijah <me@elijahs.space>
Cc: Elijah Wright <git@elijahs.space>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: move buffer in trace_seq to end of struct
Message-ID: <20250902160020.5cd24fce@batman.local.home>
In-Reply-To: <ce062d82-41cb-42c0-b970-1312dbcd1094@elijahs.space>
References: <20250821053917.23301-1-git@elijahs.space>
	<20250821114355.6ee546b0@gandalf.local.home>
	<20250821115359.3988b807@gandalf.local.home>
	<ce062d82-41cb-42c0-b970-1312dbcd1094@elijahs.space>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: aheed7jre5tctyd4a9zttq9meeqcbz4b
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 07B6F2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/RsgE/54onJHzE4UF1gVAgykramDhlkFI=
X-HE-Tag: 1756843221-140234
X-HE-Meta: U2FsdGVkX19k4TwT7JHu0iW/Cb/iZs94+UMKGysDMsq5JoxWsRQ5+vadRcZw2Bt4Zifz5agf7ILDQhupUs0/aebG/WNVnd8sGW9WUeLOZvOhftIr30E9KyDskRxo1QF90QbpO4wUsxdPYj54OiaKKnBap3wNU4FkAs7MYDaMUv+bUamE/5PfBE7mfKS1KExxySjP/FZL/Z5CtC5G7OdKTEbkRuusVzsj+qmVua8zvhsdhJMld3iLO8+AoVqHyVkpXApdSB9g6Zf893XWcNZuetW550AHUGmHQpDdmMolVDVWObOBYJpcdCJ7ranxYJh/

On Thu, 21 Aug 2025 11:32:17 -0700
Elijah <me@elijahs.space> wrote:

> can we maybe encode the overflow state in seq_buf? check if 
> seq_buf_has_overflowed and clamp len back to the used size 
> (seq_buf_used) in a helper?

I could add a bit to the size?

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 52791e070506..ea4996851901 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -20,8 +20,9 @@
  */
 struct seq_buf {
 	char			*buffer;
-	size_t			size;
-	size_t			len;
+	unsigned int		size;
+	unsigned int		len:31;
+	unsigned int		full:1;
 };
 
 #define DECLARE_SEQ_BUF(NAME, SIZE)			\


-- Steve
