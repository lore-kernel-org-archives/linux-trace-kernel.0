Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875133BC687
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907449; cv=none; b=Rlb1we/84+SVO0OoyHGC91ByinoXtlTL8RiuV/qHWMfXgVD1nY87nfLjiDsNrC+a1p9PWBBp21tHlqdkGPc/RxvNBOPiUHMrE9m1BZcBQrO13ab+hlbZdpOt2Q28/ISDh+OsBelvT9kFziUBrufOooICzZLYBcYT/myO2HH8Y5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907449; c=relaxed/simple;
	bh=Z0e3fNhe+NaGQ7aF97lAgqz2X1g+cz/s4bLcZmj9h6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbnEc+OFDlKsWutcantPj4NW/Mv4SoHdtkwfUWhV3AgiJa4YHd+zLKNS3l60faaNrqYRf24baHIO/7p4iRePBVZRIMXyMA6V1+1G3E9v3rQvhEApCqY8b0h2r4z7bPmF2M9aj3KiYk6VIjN8GoH4etPa6/2JpAWqGKk2N8RZu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUZUenhG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUZUenhG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46ed4f66256so461839f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782907447; x=1783512247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GirbTUHOpf9mltiAbkDOh+lvT6shrpDnbYlH1YZpjmE=;
        b=JUZUenhGqPKKgp/p8b/lA5uCsXVdiDd48h2omN2aTU5JdIvxCiXEAJJsgl5PidAeks
         /gtiFq4RUFT+GoVhOE4WJtNhOlNMMIz+XGDZHnHEaw9lR2jWqkULWaNTRAn/y+7KuVkU
         38cjjWeKIdAP0N60oC8TmkixB3Il70GfpwAjq7fLkkKQypy0KC1szLdPve3sEOiPr/QW
         SnNW4vDwUQ5RvU/atDMmYq8UqtawtmS5GZe9H7oRfQxTPHJ9SbjtCCRF0VNmBBUG7geK
         tArQlP4AdmzGBwrVtR+W1F+gwBhlGjcIm80knJkcakycjFyNpdYFaB01Y9dzWHBsbLz9
         a25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907447; x=1783512247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GirbTUHOpf9mltiAbkDOh+lvT6shrpDnbYlH1YZpjmE=;
        b=I3Ghppp37zCONCqa1zR2R6UJAnyoJt4cJyqcSsJxK+Om+2QmZ4kbAlcYu9LQUjp4SG
         ttuCUTlDV0+fjzX3tkTkAa74qgheA2IOP4lLYBSI28owV7znyYQC5CJEx1WqPWzRPOy5
         B/uVLaACaKf6Mju5bwnUxeXNfA0O2Nyjm02p5xXAO/zgfHgE7+NzpnPJs5RH65P8Tn+c
         FRKDu8nguWgHcDIPPgQ8ArWEGDMtY8QU8gZqWggF1cZ2iXV2OgPG4ahRJsUtn+eI7kKF
         JwsWWMQyWdpouO4rQbJreXnOjdipr+5HVe/eo9Xd42dLX0NqXbjK0o7/RU7WvGzjwoff
         ngEA==
X-Forwarded-Encrypted: i=1; AHgh+RosfvALIbk6QYt6dG6tl6ByMjWt0U2knLVngeYr8lSXq6vTRur4w9GnYz48l6/o38mMYG0wX+e6JCNfernmhIEEi4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBUN7U3Rz24r2VcioTNgatSnSzdxyOcvIWkNj4ocvXUkZpDTuR
	LdSTxZ90XAEVM19MgST8Aza71/P33gXQ0vluFHEuZQiaw5zIguHXNXT2
X-Gm-Gg: AfdE7cnNsYjbBfzjiOL0/7jice8CqrX7L2BQwCIL1fpWiLVvU0sWG7SCo0OHwbPznPh
	4dQlPVDtbzU71leZtdf4cBISqPBxf4xnxrsRSCrMpssKiP5NCdUdbWLSffwa/zkwJShXn/EgfSb
	4aLglKNyZKTIG3SOmF9W4JYGn4/QK1IffXhs2m6Gd71PCAPHrP/lFdXsGlKgrtAmFAiqo0zJInJ
	y/tVJGungzU+aWpW+noKoS1I4nO/RjWKZ1XRFaGh5BVeHw4nYLYNyQoMGeGqRaAbXC8QN1G+2h7
	9hvA0lLWp86i6O5jon27PK/r3Oh2sOzoTpGGgFobYyxvu5R52qInCRI7d/96kMWB3ZItI6V491w
	BbqQMfjl50PjiTV5L2sSKgPb8NR+YcBNsybFtG/TUZj9Dx2TwLlomr2zrPtduNMcspHg34/2mrY
	CYto78xsBBufJr+ySFfi9ZsrRVpawismwK2aEuyd0gWgXJRQ==
X-Received: by 2002:a05:6000:601:b0:476:5eec:309c with SMTP id ffacd0b85a97d-4775a7cb888mr2072426f8f.24.1782907446537;
        Wed, 01 Jul 2026 05:04:06 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475671d0403sm17307872f8f.29.2026.07.01.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:04:05 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:04:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH 2/2] tracing: Keep pid and comm[] in the same structure
Message-ID: <20260701130404.3887c0e5@pumpkin>
In-Reply-To: <20260701063822.3af87520@gandalf.local.home>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
	<20260626212356.64150-3-david.laight.linux@gmail.com>
	<20260629164912.4c1c2855@robin>
	<20260630110156.5314e2e6@pumpkin>
	<20260630150348.149e318c@gandalf.local.home>
	<20260701110407.31f7b6ca@pumpkin>
	<20260701063822.3af87520@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2026 06:38:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 1 Jul 2026 11:04:07 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > 
> > I thought it was just used to do a pid->string lookup when you run 'cat trace'.
> > But then I found the code that lets userspace read the table....
> > I guess the latter is used by the userspace code that reads the raw trace buffer.  
> 
> Yes, trace-cmd uses it.
...
> > The userspace code could probably be given comm[] for all the running
> > processes and those that exited while tracing_on() set.
> > (I didn't see anything that would clear the table when the trace buffer
> > was cleared.)  
> 
> Well, that would break trace-cmd. As reading the raw buffers clears the
> trace, and trace-cmd reads the saved_cmdlines file *after* it reads the
> trace, as during the trace it gets populated.

So you'd need to clear it when tracing is enabled after the buffer is cleared.
Just a matter of getting the timing right.

If trace-cmd is currently given all 6000 entries (if you've run tracing for
long enough), then giving it all the active processes isn't going to be any
more of a problem.
So you could just save comm[] in the process exit path when the trace buffer
is non-empty, or better those started before tracing was last stopped.
You'd need to give trace-cmd the active ones first and delete the entry
from the cache because the pid might have been reused.

All just needs some coding, testing, and fixing of corner cases.

-- David 

> 
> -- Steve

