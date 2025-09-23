Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBB2652A6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623266; cv=none; b=fPv1tmkUGeTuMP55fTaKwohXUD7hiKP7fh2umVPz1Xc7/QSAMDMfDi8I4MhKSiv8vKmCUYWBbzbwixfJGRKOLcomJBlCuQ3uRkXB9BXmwIwLItQzgAs+f8T0cquI5dBrQdFD7jUawzim0rowUtBnKZnOE0pBMN+Qu/B0lW17jBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623266; c=relaxed/simple;
	bh=jexzQQQoLvSXdpcAQ/tUipzJbucXb2RIxjwaKuZ4JnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHBtLSgMF3Cb9QwuOQrQFwtpcWVaGhzwH7dYw+uQoAZAydf1y4JckHmTSc6YqNIdpV188E19ZDPAafFw3CZ0EfzdQwAMw04QicSOJPdznZGuNDqFp/pPEhXUOm6ZXt8Swk+qSlSwZrEz934tTzGV7f6raN9LCeOJtnm4NYgTsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mRfASxma; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mRfASxma"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758623258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZEYM/d80C9hf06PGYbrd/Uuixtovw5a7O63NUD1VjU=;
	b=mRfASxmag/YyxEsnyH+7p34fI3juvOwT7Eu5FLUewinwMct3vgW96QVifEUpDhuc9FCncU
	5wDZRMV4FMBpKY/Y+dZN4I+tb28PG0QDfjXv5xvWYh11p/b+92UxSSRlV+1gLVkfv5w6ON
	4qH0WoMc8yGpg6vi6adrfZagyBXoIzc=
From: menglong.dong@linux.dev
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject:
 Re: [PATCH 1/2] tracing: fprobe: rename fprobe_entry to fprobe_fgraph_entry
Date: Tue, 23 Sep 2025 18:27:30 +0800
Message-ID: <12748135.O9o76ZdvQC@7940hx>
In-Reply-To: <20250923053803.0adee9a0@batman.local.home>
References:
 <20250923092001.1087678-1-dongml2@chinatelecom.cn>
 <20250923053803.0adee9a0@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/23 17:38 Steven Rostedt <rostedt@goodmis.org> write:
> On Tue, 23 Sep 2025 17:20:00 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
> 
> > The fprobe_entry() is used by fgraph_ops, so rename it to
> > fprobe_fgraph_entry to be more distinctive.
> 
> The change log should be more specific and state that this will allow
> to have fprobes to use ftrace too. I didn't know why you did this until
> I saw the second patch. As change logs should be self contain, it
> should have enough information to not rely on knowing other commits to
> understand why the patch is made.

Ah, you are right, the commit log of this patch is too simple.
I'll add enough information on what it is for in the next version.

Thanks!
Menglong Dong

> 
> -- Steve
> 
> 




