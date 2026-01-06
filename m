Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67753223328
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767743293; cv=none; b=GpOB7NbZgSA9zvtEKPKbhAn6Y5c5m4Ja28NBP0W9fXXam0hN30+bPvZ/wI4cm8W21O4RBqBjlGxuxt/H8bvHIfyg8YvmpfZ8cLGcoGAy4Of0bAqKZk8HBGCShkCkuLqLdsuz1JleWQSCFkVSyqkZJCIcmi50sbyor2hCKS8FwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767743293; c=relaxed/simple;
	bh=qT8QyIEYv5VwZK/5mmr9XyMl+ChjYtNyi2gpBcHHnpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLIa4qDiHn6lrJ46NkLRh/obICxKMM9MaVCsnykVkCjFNH/q2MdwG9i+YAwymjMafBLYAVGHaSojo9Pr/RduvEFLxFnQxIrSYuMHONcTZ3KxJ4L0VFWH/+fLSHJ/J5mWOJt9AviVNsrxaifboebwjiQcElbImp1vG8PJvPmxCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbULiC9p; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbULiC9p"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-11dd2370722so1595017c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 15:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767743291; x=1768348091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOWlu2AaGJvFmo8hu/TEBLcfBRHDijI3UTwZStUFhtw=;
        b=lbULiC9p6oEGD4D6nqjuhUD9PWva9FQeHGJi08M2mat4j12NruayQ0EXq2cCAzB8vM
         rGunygZVYU4KanfMoJHiY2hBR1rZMZaZgeKiPHPUbEXFiXAPng95hd+9yzyRlaNAN3oU
         e3VuzdyvlV3o88zfT6N7xTu8iwldhsA/vbETuWYyQi6yvI00C8Z2jFJ8uFAaYF3auYCF
         zuW82jSjbppsoPX3RvkeA8GIRMbdrrwcJbrEbso8NWnDTKK7AAHyTaaAIagA6brv1R52
         7RZmINIgsBk/DD6Y5EdiMOQ/FQFgSQuzfqPajiId2laHHlNPCp234c4oL+ZW9DrMfzpD
         YuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767743291; x=1768348091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yOWlu2AaGJvFmo8hu/TEBLcfBRHDijI3UTwZStUFhtw=;
        b=HY+DBqgHvJc42r8ll3zjbhp16h2SYOJ8c2L4sg4DyGnoo3DcJBSzozuHYH1OOOKhfT
         ubILZFl0LL52aCu5pn+utevRRQ3ZrjkZIGGCeLFr5LoMdYiX2YhF5BRsBe2GtXD8+CAn
         exE15ewjbYsE7N3vBye4uT0Zl2DUezKqiE0Pankrxzpb8jA4x7Vn55pJtRhiewSxhSHW
         OnMVSgrfVv6Rw6GVPYyJOczEkXE6T0/Ry4LuBgt9+RHjAOk5r207pBE9O5T8PGH//ewz
         EufS38f73IHicCfmWyo1O27jPm2LSsmJpLVMJBRRX4KAO+Vg0zLrOz672cvfYC5dFJWV
         FwpA==
X-Forwarded-Encrypted: i=1; AJvYcCUIpUHlTlyRmGnJUKMN3q2hDN7Ns9vGmmEiimRYZLAXl0d4kOftM606Txvgh0ZWvSzm2Jqh/onVo48502Fxhc7dvhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjbAlPwm9qqfzX5Ufs5JxUpjjvS/yI9EQOhYH97PhGsnADyQM
	dGroTcLx12rPRzze7/2mHinDjujZO40TDU/tcv3tBwxAwtQMHAkMbUtT
X-Gm-Gg: AY/fxX6Fv2z0FyaWL4iSIzQV3yvPwPjcU5kHuMZeV9I55xY4/aVHJe8xRH2vanSKrHT
	/Dk7v/Rfga7yHHAPwZrgl5LFrnaGgl4WXU8vxImnuI2huIEexDcgMxzpvTnupnZnfsP3sEErn1Z
	Cs1u8eJSOMH/o9LeOhIXy5MFfKaSwk6ck/NJ1DlrTJmSuguqfs80Sjh6Eh7W4rCw/ag+gHAAALt
	Bz2h/DZxAmA33OcMwVUuBQ5I4r16VZzbsY0/V6m6R3X8sSKrK1TB0GTkugMpivNbdqPJ/sv+RDE
	l1fpoep/6y+A8Sk01FX1vuVCzn/hSxORxbCkBmRzx4yNk9l9hwW4/CtqWLk0BjNjDDBBtMoxRn3
	KT8QUhkQSRYaicVPiusuCZZ05c/NXsGNmqNKLiIOonDJPBnFZL0aHBgo29JmVa9aPweslBa6XF6
	Pok8M1LAPOzcvvQ5jsq/7C5jr5
X-Google-Smtp-Source: AGHT+IGf9u3SwMMLL9rLfC8ghLYF2jXHmsnIuTCRiI++vO9RDAlRP0jYEfd4kiZdHjWNU1B/Xctqkg==
X-Received: by 2002:a05:7022:629d:b0:119:e56b:c75c with SMTP id a92af1059eb24-121f8b5c392mr660379c88.33.1767743291283;
        Tue, 06 Jan 2026 15:48:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm7578124c88.12.2026.01.06.15.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:48:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Jan 2026 15:48:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Do not over-allocate ftrace memory
Message-ID: <b4ff0141-7012-411c-8ae3-87313a756dd6@roeck-us.net>
References: <20260106203533.2896197-1-linux@roeck-us.net>
 <20260106161844.02ab387f@gandalf.local.home>
 <dc80ae8e-54f6-45f0-bf2f-69012c3b47aa@roeck-us.net>
 <0a9cd12e-6db8-4b41-979e-95f06e9390f6@roeck-us.net>
 <20260106183815.33fa41f9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106183815.33fa41f9@gandalf.local.home>

Hi Steve,

On Tue, Jan 06, 2026 at 06:38:15PM -0500, Steven Rostedt wrote:
> On Tue, 6 Jan 2026 15:05:25 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > > > 	/*
> > > > 	 * Use ftrace_number_of_pages to determine how many pages were
> > > > 	 * allocated
> > > > 	 */
> > > > 	pages = ftrace_number_of_pages;
> > > > 
> > > > 	start_pg = ftrace_allocate_pages(count);
> > > > 	if (!start_pg)
> > > > 		return -ENOMEM;
> > > > 
> > > > 	/* ftrace_allocate_pages() increments ftrace_number_of_pages */
> > > > 	pages = ftrace_number_of_pages - pages;
> > > >   
> > > 
> > > That might work, assuming that the code updating ftrace_number_of_pages
> > > is (mutex) protected. I don't immediately see that, and the
> > > "mutex_lock(&ftrace_lock);" right after the above code makes me a bit
> > > concerned.
> > >   
> > 
> > One way to avoid the locking problem without potentially risky code changes
> > would be to pass a pointer to pages to ftrace_allocate_pages() and to
> > ftrace_allocate_records(), and to update it from there. I tested that and
> > confirmed that it works.
> 
> I was originally going to suggest that, but when looking at the code, I
> noticed that these variables could be useful. They are only updated on boot
> up, module load, module unload and when module memory is freed.
> 
> But looking into the module code, these updates are done outside of the
> module_mutex. This means these values need to be converted to atomics as
> they are updated without any protection.
> 
> Yeah, better to just get the value from passing in a parameter to both
> ftrace_allocate_pages() and to ftrace_allocate_records().
> 
> Something like:
> 
> 	unsigend long pages = 0;
> 
> 	[..]
> 	start_pg = ftrace_allocate_pages(count, &pages);
> 
> [..]
> 	ftrace_allocate_pages(unsigned long num_to_init, unsigned long *num_pages) {
> 		[..]
> 			cnt = ftrace_allocate_records(pg, num_to_init, num_pages);
> 
> And have ftrace_allocte_records() have:
> 
> 	pages = 1 << order;
> 	*num_pages += pages;
> 	ftrace_number_of_pages += pages;
> 

That is exactly what I tested. With that, I assume I can drop the
code to update pages in ftrace_process_locs(), inclusing the warning
backtraces. I'll send v2 with those changes.

Thanks,
Guenter
