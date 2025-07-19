Received: from smtp.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172C222577;
	Sat, 19 Jul 2025 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752907285; cv=none; b=a8NmaAHQlyvoxOhZc+MFIkRCk9NsFgZfCumF3RVf+uEr+eqBhE467zvDwnF3FrjRZxMJkg9bBIQ5ca4Zlc+ANjB4PltPHGVWw7Lk0R6Xa6qiYy1Hsm+Rf52t7QEd7Wc8XarwP4fyDvKntNpTi313J8zs47zON2J1A0EiH410mEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752907285; c=relaxed/simple;
	bh=EmgutOIrazSy9MKspNhrUXhh1pDRYo7vKPSgKaMsDW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dH3V8VxxgFRwOnTFWpaopDW4lBnzvfELRYuZsy1poyCMNY4ih+8f2v+6xzxy34CNoqLAFdWY2hGq4l4z3KXRuv4T6MLNlDHpXsTZP+SesiyCSUlm0YNAUzBNLJAxIDQWyQxE2pL5g1fGtO8hWnmAuaCHMWLRng7z+cODk+OcwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lMAs4Ikk; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lMAs4Ikk"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id d174uK4kHQ4Mmd174uBTbN; Sat, 19 Jul 2025 08:32:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752906724;
	bh=wT3d0Bk2O+o+XayP9x++VQxDYkqNyteMXScMP/f2Qok=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lMAs4IkkO3iYnSa4DZfaacXlYXSCBgUo2row+vlEHmSYR1cfJsXxpc+0brdCVnI8g
	 uKvgTSYqhRlHM6z5u7iPZCVOz8c9M7yFO4alJkH/3PfPtpC0jPYyplI2Vg0FqQL2Sn
	 xgBaB842sMK8040bbLqssruU+N+pAqEJWQCKdYDlEv4FwoH4vCyPfw51lZ3BMLjFpU
	 Nmx0NKPebEZXgrvh65cDIKQKabzm/GZCfwYS1VoqAmdc+0Y5gIqTulJ3DVJVEInaMH
	 gpP1+Oz162YRV7ZkH1QB2Jq14koayO/eUUzTq7YFGoQQUipjrnsDxxEKhRs7luaDN5
	 vfCYPHKb+gE6g==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 19 Jul 2025 08:32:04 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <fab51e17-c1be-494d-8591-3eaf63e3e489@wanadoo.fr>
Date: Sat, 19 Jul 2025 08:32:02 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: make the const read-only 'type' static
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
References: <20250714160858.1234719-1-colin.i.king@gmail.com>
 <20250714121554.1365c93a@batman.local.home>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250714121554.1365c93a@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/07/2025 à 18:15, Steven Rostedt a écrit :
> On Mon, 14 Jul 2025 17:08:58 +0100
> Colin Ian King <colin.i.king@gmail.com> wrote:
> 
>> Don't populate the read-only 'type' on the stack at run time,
>> instead make it static.
> 
> Hmm, why not?
> 
> -- Steve
> 
> 

This is more efficient because there is no need to copy things on the 
stack at run-time.

It also makes binary slightly smaller.

On my x86_64, with allmodconfig:
Before:
======
  229194	 924492	  35104	1188790	 1223b6	kernel/trace/ring_buffer.o

After:
=====
  228873	 924268	  35040	1188181	 122155	kernel/trace/ring_buffer.o

CJ
