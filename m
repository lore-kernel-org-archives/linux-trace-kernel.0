Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9082222AC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721209; cv=none; b=A/ophWzHSQuHLIv6xVZxLcbJlgwrgY/US461bcjojkI5tMXb02Zi24nh7a99LK/eFqymiRqKJwwy7CcLhm6/PrIhrI4LsDe8P9Ws72g2QtEBDjGbuV8bJnBqG6BO76YA9UkrtLjbJWtYPUMiAd2SqGzNHOPLJxRh6NbSROJejGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721209; c=relaxed/simple;
	bh=C+K0pugC42dKNe5Lg5PpIsrRcNGMne12C9aznegF4kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByrWUEG7tPir3vyAR6urpm7KhnrmAd8jZRkI/aCYP5eAEB+BSkHYdc1tEU6U/gfsRzHkKFKCgKf9ZjG6s7KdHamc6oeK1k6GF5OEl+q52YG0WnWCYPZGIDxu3uiU8U2V8kI9fdA4kicCJW7aF6DIfjw+wy/M1b1Fl6uEJkAqfSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Ap2na+KJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ap2na+KJ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso1849187a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1767721204; x=1768326004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C+K0pugC42dKNe5Lg5PpIsrRcNGMne12C9aznegF4kw=;
        b=Ap2na+KJ0rWRrIlNtTjIZKRslkOBP01Yo9XGbuFeyYhuR31K+01h545Uxe5Z+Ckg3g
         AqzVtioIo6XW7wo86waeRvqwcVYzb52ukq27PJh5UBe5EdubBwL85XY//YlX5XY5PXyH
         8uWtod2YBk/t1bMx58O2cuCFHh+Sy99FhitwbI1zO+IJ5IeYnXQTJSkUkbE2CRWsJ5bS
         QtGtBIoVdQ1RBMrVymn0/9fLk8zFU8/fOS2oTtp3B1elYb22L+E2QxKlY2HuCYLp07iP
         bDOEeCKiD/I9Hk8RviW8jhMvBO0NPpWP/8HW3IhN9XrwvSFJQma8lIRcejkRWswhBVXv
         ZX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767721204; x=1768326004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+K0pugC42dKNe5Lg5PpIsrRcNGMne12C9aznegF4kw=;
        b=hgOZ/NofX42sTWP1dJFEfR07J43/N/ZMDsf5111D0cmex1EwQU8O4l3qHT2S7YmXGD
         L+k8Fp14Pkx29nx4tzJwibCsaAz8zFnWZ+wwaiHPRW9c6YyEPnsMg48Z3fKpIBWb6h15
         1P/H+6ooJB69f97C9vHo7Uw+/TAhQtDdxt82Jx2iiAI5LMQ8vZti/C0iR2aw0QKD49yH
         ox7vAKERY4Jxtl7juLe0TyIi6hHjZqum/yttk0/pyiU8+gZ68JIkUf/2KTDsicjX9xH/
         4DIWV/pvnjZJcCjBD4p9J5K8wXFyDMtNOtFiZaDVnuejyCApi4JuGFfToeLDRJdNJZeD
         tsAA==
X-Gm-Message-State: AOJu0YwBHiuUcTeUFr1EAzVV4NrGXv2Qjsw1DnlWLVNJymr8eoPaLy0x
	eMvECxvgACrVhbecgQSZpqwZg1pFXZibLQ7Zvnro3xOor0MXNnXyPdFWTSlvGwRaJIT5mqh17t5
	Xkbx0wyQn5zVGEgO15IeO5nyTdCm31TSQCg5RFROC
X-Gm-Gg: AY/fxX4dt+Am7nvSoHHyAVq4whhSBwOBJ1bjps4ppQ9BH7P9EeO/g+7C/50xvnOIDeQ
	Po8tntFI6W6c0Z1BK4AmeGajmOlh05cSw9ZwtOTMDbSSKBn3IAV4Tx0zRpHyZT0mL/cCdJvyxow
	MCbItWHKlcmA6auj9i18/7CEuK3VkOGZCsTs3uCh4PQPJ/rmWVdOE2snFdPB9+RIqUSs8G4toHd
	SHI23F43+DJJZYoGb0I7c3ir4Fvtmf0R4/WpH1v88xyy+8AO2INlQMDgM9vljHrkjTOLNYvbfnB
	C5dLuz+AM62G2sg2t3l2dbgqa40=
X-Google-Smtp-Source: AGHT+IFuxDaI2kZ7cHSY2Kz1GjfzJaY1eypcwp4cBlF+EgBynjn5Bn9sDbWxNkqBQGo+Ag362FM7cepnVAWFp8yjRik=
X-Received: by 2002:a05:6402:430a:b0:64b:4c70:a5f0 with SMTP id
 4fb4d7f45d1cf-6507967c1f2mr3123713a12.24.1767721204380; Tue, 06 Jan 2026
 09:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABEuK16m+msavH79AZxTRSqOsS5MQmOnsZZ8tZuKY5WWwz3bFw@mail.gmail.com>
 <20260106122145.42e4ec09@gandalf.local.home>
In-Reply-To: <20260106122145.42e4ec09@gandalf.local.home>
From: Sahil Gupta <s.gupta@arista.com>
Date: Tue, 6 Jan 2026 12:39:53 -0500
X-Gm-Features: AQt7F2rgE_ZkqaV6Qp1Le8nRnQr9lZIjOGXOC391_JEnLYDbd_vknu4KpfrJbhQ
Message-ID: <CABEuK15immVy=+Ji3soYwB=q3tKcNVWuForEhQSPqNOqOye3bQ@mail.gmail.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>, 
	Kevin Mitchell <kevmitch@arista.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sounds good, many thanks.

Sahil
