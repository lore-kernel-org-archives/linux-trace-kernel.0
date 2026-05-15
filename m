Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5073B3C17
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855363; cv=pass; b=AvlF6dKy3YcKWE464X+Pzsob2AodM0ZC+/0eXf1loOMk7sHYJnBSODpzjWdgOVPk6n1SFUs9mIh1YbZ3WrYDjApgs00jftqF4/FLIuHo+l2Q3pvGIQPB5b595rofe3TqPGHT/cpxcSEYX0j/PM6BfXTV4yBcwMSCydZiqcyiJWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855363; c=relaxed/simple;
	bh=dP0dHvrHOos0cd7ep4x4t15zx+uD33SpmwZ8H2CSkSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJSJx3GoNkwJfu5vs6vZEJoXZLSZ2MUZ8rz2wTwLI5FVjLwFwbD073VB6agCSL4MKsSAF3IXFw4CU31xlvDp/s6pB9HZIJs+cQCi4pmQrpbdQ7eG+rvbWhG99F80S2cDI9SBip9BJI5aaV/A2UkGdM26iwOKqktv1+PkOw0qPqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=g7er/OD6; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="g7er/OD6"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651c5d525f6so12930663d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855361; cv=none;
        d=google.com; s=arc-20240605;
        b=RKyIODdgV8AXmxdRMecdXI0q43EaRl1mQRe8kepY6AAAel/9b812qNqp0YM3R9pEU5
         g/Zw3IOQaPg2Fp6j7/oc1q/JA0xVRkUYpdjNCVk0r3vJtyarWSD1+2/0p8WNTQfsukZm
         PYs1jLD70lulPWwu1rn17vAVgDwL268bVAQpUliaMCNP15KFUtvsKsgODXSAxeA6Xnbh
         EaE+WNrUwYPb8xDuxVBgwQ8y0gZ+eSIv2LLcOI44bTUhK4LBoos6pmD5VYXI8gB7rg4Q
         E706bI7uliPH0XUUvmtLoFu+34J8S3t2q7qyA1tRoA32ESuNfzV0mhOqgJaw0gxjYttU
         7prQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dP0dHvrHOos0cd7ep4x4t15zx+uD33SpmwZ8H2CSkSQ=;
        fh=qj9C1s7zdhNUuZyAXN7u6rVzmGMlAwZDCMab2RhToyU=;
        b=QIkNhWmefl1pZ3tEmy4M66Z1BU3kPYlu8px0gknHsKGjcxh1bNiyaj7LMLANJXWflj
         vmjVVaKpZY89cqIX17uA2+1aKYkseEvQ1cSZcU0xcBF+vM66hqv7MAFuo+iM1WtSuKC6
         SvSQVWFQU6/KB6A2iRpfmpVPa58tkQ9KWVXlELN4iGZuuWRtbSOsCNF5/ahqm212BC7a
         XPWxU7Mckgvgbhlql/B9G99paPdmowh4HDvF++kvg74yK8PnRUjyAFyomgMp8jy6qD2P
         tfMjYg//sczgWbAZ4l8szCCGWLDUsVtpGLNknB6q0s678eSDQxLkE0qfG9lA9kkGfdeK
         J3jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778855361; x=1779460161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP0dHvrHOos0cd7ep4x4t15zx+uD33SpmwZ8H2CSkSQ=;
        b=g7er/OD6YZ7JaLMdsun00Xh2gzqZSnvOC5wd9LBfuFRQ4cuLrABBZO1FA3SicX3KFm
         nx2yJjOCThEe7u8xOyr6u9Q+qjQHoV2V62uvTw911FPuiMv40c38JIJm1VzuvwSFGEeB
         ZuViisxD+31HEGrTCeZvU81BvqooJwtICL3KGilfc7+dNPt9y9Utg8jILIcvGdPRLsI1
         2/d+2JwjQ0NFWqnaA+cVRSo3kwz1iBXNodEvSVkebUfVCzFjSFJPL4fN8V1PRl/Grztu
         ki/q9a3qFiIUOcQa7raNM36FSPIS3jP+Lc4JDq8kJTnWbfu9d4aHOaXWrXsihiCLKuyl
         espg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855361; x=1779460161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dP0dHvrHOos0cd7ep4x4t15zx+uD33SpmwZ8H2CSkSQ=;
        b=DybRnfuBGlSQUtGD7zzp2lcwcEEjW8UeLB4RkRUVv7f3adAb5Zm+talvOpvP7kmPxq
         dao9i50ovdxE/mNRc97f5izJ5dLeaAPCbgTYqyxGcwqe8aTHpcBPCM2/0vrCVLnMp4pH
         6etN5joTi/2ASHgDjTgexKdgpjS7Sf8Oe+ZXs7KbEgmtOVPTkPxgW1DAJSmyMgFIrYu8
         MEDBF996TgaJTo9HI89BFzJ9ZL0ChPtI6rgK/d4HF68LZGQ/3w9eB/LYv176hIAAjjBy
         M3F4ozbSaxMR6gqeutJ72ou9zR+tO7BGj3034BEzLeORqbjByJcU6IEsl63iLZl+uSrM
         OBRw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ux6t6/QEsS7FG17H3EJ6PQnp1orteOe8lRZQgqQznpk9/a/9CocdqVcX6mI75rXzRLD1dZR72Q4T11FV8joUaQF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8z3CNl9gSd5JDnnT2/Q2ztuyzNAjhPRqUXkj2D0HV7vruGqAi
	StAt/MqIig2qlRPuvv8kHTPfP6qxtCln4twJ+GJ/43k1TQT+06LUzwqDnv5FAXI7cjzdR++gBYZ
	IoRRFDjZ4SVx/jN337TpMIBde9k3RVM8F7zwcK+jOHQ==
X-Gm-Gg: Acq92OF5JSnfU9Aze+l9Q8cN7MZK6fN1I/f7Dgp0PpBljmNpiF48otXILAp/O0iR+DJ
	E5IUCB7I2P4T4Td3AAnD6sh7Hxv4zTj4uPTzhdsA+UJdk0SyAk3iYMxpRzUntzaQlIqo9kFjvf6
	qkziFI8/TDeIQZmLbhIQ0vFQMQhTZS51ti2cWFR1C4+lCS39plVkz3rqAuIH76u8++LxIyqSqil
	8wauwdUbBZHphVm/gZrkvCev4mehTL/l9v4jBfrc2BX9z3o8HnhIdVJQ8zaDLRv4xNPCAn5Y1xs
	pJ3NTcvn+1OKRltXRpNRtUec9kMfvJXCelxgJhXN
X-Received: by 2002:a05:690e:1591:20b0:651:b477:71cf with SMTP id
 956f58d0204a3-65e2280d9f2mr3577169d50.31.1778855360752; Fri, 15 May 2026
 07:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515135903.2238731-1-vineeth@bitbyteword.org>
 <20260515100448.715589f6@gandalf.local.home> <49e77605-6227-426e-8103-329474bf88f9@kernel.dk>
 <CAO7JXPg+MJXF8smC9qXs93YziJT_amQwWKVW38L7F5XdS9-SaA@mail.gmail.com> <e6e5d079-25f2-419c-a992-5651ecae26bb@kernel.dk>
In-Reply-To: <e6e5d079-25f2-419c-a992-5651ecae26bb@kernel.dk>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 15 May 2026 10:29:10 -0400
X-Gm-Features: AVHnY4K6QwXkYzOlWsg8Ut69QpegiybtYTjeTkJ0n8psR-YW3kWPDDSPswXxZJs
Message-ID: <CAO7JXPi9Ph_e-MMxtcbhfU5Wm1i8VA3gkHtsAd5-Gd2uK8GZVQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] io_uring: Use trace_call__##name() at guarded
 tracepoint call sites
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>, io-uring@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:25=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 5/15/26 8:14 AM, Vineeth Remanan Pillai wrote:
> > Thanks Jen :-). I can probably send a follow-up email directly to the
> > maintainers to prune this part, similar to what Jen did. I guess one
> > more version might feel like spam.
>
> Jens...
>
Oops my bad, truly sorry about the misspelling.
