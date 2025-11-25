Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088A2DC35C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059781; cv=none; b=ZBGZYpfA7FaFMsJ9VVxfOp3gTLQttLkOjtiakyMuB8uP7keNrfdOwigMSjGugi2hXt19jig6TlvRNrtpHpcjUNa6ZU8b7U2tdaNwVr60U2PpSfj7U5FBfgW+s/V34KwCYGBSttm8TpARc7CJhPLDbGw1xu2RYim+tGC7mx8zZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059781; c=relaxed/simple;
	bh=t3TMJXrcfhLPaewtUx2ZbtBTa4bLRUKMityiB3tQViE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xk/HJiRHbY0phEs7SrC7W1ixnic2mWs6v8+GOr65O7NcrnVViRHAOROZHC68GlmkMw3mkT4oV/0aDM7nyhItYSmJVCiP3jlnVpoPL0cwz5+lZYJnYFIp4woIjwa15Ga2bYkFgoVq2CAXUWkSDo8nQIT+uKBYJeqbW+z4mcD7OR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ApYj7UxA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApYj7UxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764059778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3TMJXrcfhLPaewtUx2ZbtBTa4bLRUKMityiB3tQViE=;
	b=ApYj7UxACwcEmeB5Wzp0Uvklaj6GnH2dcNQm2D1dZ/k+Byg+NhYFgmhf9aI0XJ4pFeLEf2
	5/9ZRCmCDOb9y0E1HE+Lq1KIJ1hPmpxx3GTTYPDGq4hTrHMqjWTgCjifVwqYi7YTvzWXiH
	H+/Vw6s8vpfPB/QXygSNvsbg5nmCq/w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-LcqHpTJ-Pe6Do3rKLMbMEA-1; Tue, 25 Nov 2025 03:36:16 -0500
X-MC-Unique: LcqHpTJ-Pe6Do3rKLMbMEA-1
X-Mimecast-MFC-AGG-ID: LcqHpTJ-Pe6Do3rKLMbMEA_1764059776
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6407bd092b6so7362966a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 00:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764059775; x=1764664575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3TMJXrcfhLPaewtUx2ZbtBTa4bLRUKMityiB3tQViE=;
        b=lFZN1ZO8ZcbqYcRRRCtzEQbDToxEC+RWUhrH+JlrBQVE23D8NHLKlOyLsVDd2ejfp4
         Yv71CBoQKhBwfd0Zvb4sABW6Y5xlmKuFAn/YiqamKx/JBIIJ/hwk8cfclOUM1tfgsmAB
         5/7JHyRrknuN0zG+Mbb9xG/uZYkZM2Ys0LKt4ngmXjl/1XtQceQraZR7O6IMqGVG8zBL
         uGyueurGKn//ISAZ/wgCbvwr3cWouJysVqFwigx+J/wu+WxRR2QUzGqdYpJarfN/rYWH
         p8915/OW0WuJnuxWQhtL70djju+rbw2mH4+tEDaLj/Zt42auf2z9CYIRdOz8PNNdqIEj
         W0sw==
X-Forwarded-Encrypted: i=1; AJvYcCX0N7SToAXDpi+hzmYIf4Apt/OPuajgDtsynxjUIhPLEFEmmJgEDzfDE1+rb6NF7U3F2+AO3Fl5oPb+c5GE7/vDQuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzmii1UL6TLRxtqZqJ6enxcni6X1b7j6Mji6c1ZajBR71rE+ay
	fNO+GXD776mnFLTk5P2PmBTx4dtjttsphiA+4uivmFcjGiD/K9KGX8Nub9O3LkM0ojtJcjvWM2R
	+66p4lS3mAF2TNEz9J3nuikaoH+IMaNS7ImMIeD3pxCLCwA62P8rLfVelZ4fApnxTI21jo97aRo
	MIifLf+NL39fIt7rjqk7Ud6WML/glyrDUWhPUj74tsCA+bWNKPITp2JKzdQw0=
X-Gm-Gg: ASbGnctMPmC5cm6QbUOs5eOXUAdxNo97Uh49c5WWBsH8D7aQiKOsGX9j/i+5rD4WPw4
	6r3ezuek28WlU2SKVppnydi+QlyvjbimmwDHqQIrgXuJuyL78U96lb7ElEPxm3JjFbg6BhC4fB4
	/95SVV0x3PyelvS2HDx4Aj+uXp+9HUNN+6HZkBKnYhLNhoSMym+lKWSnOegFFoVc3OgEGpVfkfg
	9OObuvMiCmt4zwWxCQQmWyBudks
X-Received: by 2002:a05:6402:1d4f:b0:640:9c99:bfac with SMTP id 4fb4d7f45d1cf-64555ba6a54mr14410424a12.13.1764059775272;
        Tue, 25 Nov 2025 00:36:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbowAw8xnwVcEagQwpLeobunUnRMv2eAt5SqMfHySizIkAd1BHtmXHK8LomFMvzKuYrAliFAr88RJShvATbtw=
X-Received: by 2002:a05:6402:1d4f:b0:640:9c99:bfac with SMTP id
 4fb4d7f45d1cf-64555ba6a54mr14410412a12.13.1764059774895; Tue, 25 Nov 2025
 00:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-5-wander@redhat.com>
In-Reply-To: <20251117184409.42831-5-wander@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 25 Nov 2025 10:35:39 +0200
X-Gm-Features: AWmQ_blFJar_BkG5M8MYHChRGM_It0Cs9uZCDIO8VEBL8HSdYWDh2e3YVpORtOo
Message-ID: <CADDUTFyAAAv641OfGf_U4hVdegyAVyp5rgruF=NSNd+UPkjOzQ@mail.gmail.com>
Subject: Re: [rtla 04/13] rtla: Replace atoi() with a robust strtoi()
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hxv2fbj3qXgfOWfC9sH5ZQnNCaCr9-2C4pyEeqjQt7Q_1764059776
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 20:55, Wander Lairson Costa <wander@redhat.com> wrote:
> To address this, introduce a new strtoi() helper function that safely
> converts a string to an integer. This function validates the input and
> checks for overflows, returning a boolean to indicate success or failure.

Why not use sscanf() for this purpose instead of adding a new utility function?

Also, using a boolean to return success or failure does not conform to
POSIX standards and is confusing in Linux/POSIX code.

Costa

