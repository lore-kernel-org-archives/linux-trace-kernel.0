Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE43EAC68;
	Mon, 17 Aug 2026 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964066; cv=none; b=AdFL9pHVfaidVDAQ/LNBEsFJMSKDfGCimqSA9BlG8lkF9qlmUj9CYS8AltWODRgUjJjeux6exQZ/pENOmDqOuAVvElRXZtHCUTN8DBUtM4X3qBaki9+qA7DO8AkwmMAJ6NI1PzMkYSI/V6gOKIuNDj+Q+oWbsLZ5hcdsQAGCM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964066; c=relaxed/simple;
	bh=zcuvaydldqTnv0OjKN6Vw4wLsQTL8y+32udEKSDahG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n3VdRJi4pTGHqKIeo+738MsnbCCS4+nV3FOxqRXol/InE0syZVlHQbA+MsSDlacIJrpZPO6u1Ur0aolD7ynODgydZqhwmnAlRCATcM8qrsqtq6avmv1VkybAy9iteHh70xtyOPWEyaIWi5zBCK47RUHrmCd5QyuTz83lNfC7xkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LFf/iDBs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FUmOJyjZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LFf/iDBs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FUmOJyjZ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786964058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BL2aFNZJ5BBIoV7ZbnZIlwJsLNFQ2y/eplCbxDcUKis=;
	b=LFf/iDBsW1T1KWAX+ptj5uY94ZjftOC98Dr9bFgonG1LYl4q3MjfvLqQK0QgCrzD4uNdCN
	YKtPwlUu+N9fAUj9aaxOhGfyI661CvVCuVomLMwv0mCWWb7j3B0GNXESA5zIMeG/ug6Flw
	XPCmjvSAbXAqfLF3y4/BdmKqHuQen65gPEXBn1f5bl4d+i1xshpTotxroupyGxysGXPKb/
	9RlAcqZ7GvbAxOrKjKFbdbiiGoQw4svMmEfXui2sAFACsmNwtnXvZv//7x7IKsd70xkdmb
	5v4gGPsmbM2AGs8z0bo5J+nNbwTnQmTow/zL+PJa8t1osmec9i/GEmmEh2ez0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786964058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BL2aFNZJ5BBIoV7ZbnZIlwJsLNFQ2y/eplCbxDcUKis=;
	b=FUmOJyjZdstNmYOKDgBr5ktpgGPr7LaY8GDAnEjsdTyTujfyW1Z5XzRd5oP9nY1l1sLo0A
	t24o7U/3XXdkGuDA==
To: wen.yang@linux.dev, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Wen
 Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 2/4] rv/reactors: propagate rv_register_reactor()
 error from reactor init
In-Reply-To: <c341d0f0849f9c68b0539da49449f8ff2b2d282d.1786294920.git.wen.yang@linux.dev>
References: <cover.1786294920.git.wen.yang@linux.dev>
 <c341d0f0849f9c68b0539da49449f8ff2b2d282d.1786294920.git.wen.yang@linux.dev>
Date: Mon, 17 Aug 2026 12:54:18 +0200
Message-ID: <87tsotnhk5.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

wen.yang@linux.dev writes:

> From: Wen Yang <wen.yang@linux.dev>
>
> Both register_react_printk() and register_react_panic() ignore the
> return value of rv_register_reactor() and always return 0.  If the
> registration fails (e.g. a duplicate reactor name), the init functions
> silently report success even though the reactor was not registered.
>
> Propagate the error from rv_register_reactor() so a failed registration
> is reported instead of being silently ignored.
>
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>

Reviewed-by: Nam Cao <namcao@linutronix.de>
