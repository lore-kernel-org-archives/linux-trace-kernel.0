Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72982FC87F;
	Thu,  2 Oct 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394735; cv=none; b=SEDpfIIsZKxgWGr/0bLI9HjlS/X9P+isQZpJAEaoRd9LjmvB+RSDJN2HOykjSeDgJrW4wOS03myOtb8nYUJtSM4APIflMFaJR21PqD419ACSAIgcoz5LZEeC8kKFsFqVddnaOI8J7lhiTpPEzLFhCNUUz0q5CJAbb/UK6m2SjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394735; c=relaxed/simple;
	bh=rA01WQkZhKe14fYRS2r5JOFsP5ASi/fcms5hDJnoJZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lKjBwbIUu2BGqZKGLEkfTygfnxN8TP5btCvxEWqhF/wn2H8osEUpStDUFijfMMM1TE31I6Q0pJvzp0ZCT0Go76aQlkeQc2CNeY5rCTA/iQ5X4BaN1ffDkSGEg2pB0lC0NERj446AIUWeTUYhJk4WEPPXm35cMouxFIqPhE+YXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EM1RKYzX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1Ih9hHa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EM1RKYzX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1Ih9hHa"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759394732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rA01WQkZhKe14fYRS2r5JOFsP5ASi/fcms5hDJnoJZQ=;
	b=EM1RKYzXgfMZ8jE9J05s635uZ5it0oww6m9zlJHti1I37bkzqFj6DSVLUqIiL4eF0aBKcQ
	AaR0+EgPgRu6Qyb6zObkVVmy3ZPCart3+tSx8bHD9fSOa2Ry7c9bAkxbzuuJD0X7WifNiq
	NJKfiL7uLWVDvPG1Ze2PCP+8IuF97En9rd1W4ANCH54cz+iCkEuDvSRqVbPGpXzQD/5yA3
	HuSWgMEjVmKeLeYVl7EAOJIpAenqibV7fppIP1g73zhZNAag53HbxloArNYMYhundJ9Lm0
	MhaLE1X3TN60rCoSNw+UWyawxvogkBiKtozlFa3Ce8Xri5tXo5xn2a8eUUru5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759394732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rA01WQkZhKe14fYRS2r5JOFsP5ASi/fcms5hDJnoJZQ=;
	b=j1Ih9hHapZn0jcIzuxHHSnDI+GpkeVOw+hMW4UE0U+BrsgtAEGV4Qyv/ES3z1FdqYa7XgW
	cBcMl41SObql4BAw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 01/20] rv: Refactor da_monitor to minimise macros
In-Reply-To: <20250919140954.104920-2-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-2-gmonaco@redhat.com>
Date: Thu, 02 Oct 2025 10:45:31 +0200
Message-ID: <87frc17kus.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The da_monitor helper functions are generated from macros of the type:
>
> DECLARE_DA_FUNCTION(name, type) \
> static void da_func_x_##name(type arg) {} \
> static void da_func_y_##name(type arg) {} \
>
> This is good to minimise code duplication but the long macros made of
> skipped end of lines is rather hard to parse. Since functions are
> static, the advantage of naming them differently for each monitor is
> minimal.
>
> Refactor the da_monitor.h file to minimise macros, instead of declaring
> functions from macros, we simply declare them with the same name for all
> monitors (e.g. da_func_x) and for any remaining reference to the monitor
> name (e.g. tracepoints, enums, global variables) we use the CONCATENATE
> macro.
> In this way the file is much easier to maintain while keeping the same
> generality.
> Functions depending on the monitor types are now conditionally compiled
> according to the value of RV_MON_TYPE, which must be defined in the
> monitor source.
> The monitor type can be specified as in the original implementation,
> although it's best to keep the default implementation (unsigned char) as
> not all parts of code support larger data types, and likely there's no
> need.
>
> We keep the empty macro definitions to ease review of this change with
> diff tools, but cleanup is required.
>
> Also adapt existing monitors to keep the build working.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Farewell, macros. You won't be missed.

Reviewed-by: Nam Cao <namcao@linutronix.de>
