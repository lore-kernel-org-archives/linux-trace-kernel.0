Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A492F617C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Feb 2026 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772269179; cv=none; b=mWFbkQT/f/QseZPENFgJQCcb8oc9JCJw9gVZE+nMrUsvq25pHi1i6n2+MiknCHvenSpZZoguccPxhLERU1gBOvdF+T77pZ+gZTL9182KVD+sCL97miGSC/+tefQH9LMNbsJ3iRbnLW2pFbWPtR3+dsKh/ojSEfDcFbiJ0Qgiai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772269179; c=relaxed/simple;
	bh=pHV9FQIEnr9FSU8z25zloREHQ5f5WZsMMGhRFoedtWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPzU5ay4PQlQQD+LskSdb9PRzagR7VqKdrp9QiWvsAdffhc8iCH1LCCxRt07KAuNsYFbo6TZnZqqduODbh/xwy6GvoKT43FARcB7o61GQTYLsRsmnygJcCQeNoegay/J113QYQErOm1aJq+qLtohOA7DwPuL40JIc/s6gdOVwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5xJ1K5H; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5xJ1K5H"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-483a2338616so17270345e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Feb 2026 00:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772269176; x=1772873976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHV9FQIEnr9FSU8z25zloREHQ5f5WZsMMGhRFoedtWU=;
        b=m5xJ1K5Hh7+p/115cV+tA1zImGUj5fyhtaDfbamoA00g04x1rG5n9U9vE810KfFUOx
         zdhZGxJkXhAhfGDo6duYFNqRUjKMX9F1t8g1yFI0SGwFFzE3bOnUYY4d3H5y/EqQ1H0D
         topuBm5pgDKx1yFVgbeqo44wqLxyJsGuCdUcvBCj8xyoAAcWEiic+mKM5uokSwWlW2wf
         QuidWH7AiIBfhvNAUH+oBnygTIriTEs8ACG6Asr4HLW8tvHPj3t4ajq4EZP//QVRRAXQ
         hS8xA4iJvu71TcXKwl/86/TF5FMvrkZCzjnwWQx5PXWSjHXg3n0mzrT5RU2CrtZC3u5T
         z7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772269176; x=1772873976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHV9FQIEnr9FSU8z25zloREHQ5f5WZsMMGhRFoedtWU=;
        b=vFivu19jSl6wTTvZ5VtyZ6pvlBFgCjflelgn2oAaNcA1uJGommZG6vghyGG2u8PwA4
         r0zAZqNwXukDUsYP/U74kKBdI1t4+QcXiChCPLuRAiORI3qGDZxRy1Cx/4PY8u5453TT
         LSRmMlj8t77NusxmiQG13Aw7w7QwuIxaOJ0lrwej8nnBSfsml2mvuV5yw/pKuRxi2Esd
         k9qRz2T0L33hXPC0e5JgvrJWRSrn1iWTJUsSK0d/hLgTbmj2m37T7qZrCn358ypGVs/v
         OidvDDkhmj/BcUDcrLoTWl9fPX1s5f6nRBbzYn9fB/SaMGl/MXYNvJ+fQ58BegW5RnJB
         wSsg==
X-Forwarded-Encrypted: i=1; AJvYcCXAGXn6oBSLIR1OZqfdIQMCTeuWxyQdRnfTxIzJdsL2gdxfJWiaIsPV8byJuRCQiSyaGw6FPPMygMvXnL4vC2YTGI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOcqTB5Od5D9VbwIoHZBXdJQecy7bBm7lUnZGkPs42p4hVDXJx
	nI6erG1duh5m6OY8e3EWJMGA20hvR/xoNpGWeiXvQlEFPv66nY1ijA53
X-Gm-Gg: ATEYQzyEUieh4P5/Q11o24X6CoYKK1QFZ7+X8zeLmQ05U8cwoIfj9NY+W8qEdvz7/Cq
	nt4tMzrUMwpPoCpYqidg4SkPOpT9SXw0ntelFeJW07OEigTPTXbX8aUABgetuyNDSRl/vTKdXo8
	3vdJHcKQaHnRz89mLDRVeBiSyTLxxPtV+ji/B5HFKuOfmS7/q0TOBx8seSbA8vLP7cTsUerJkyy
	NiiS5uaSTSNeDBFgumuvtcevVRyrF23eVYU5QCPC7H6900fguF6kDn12QiChnT5JMf1/upE3p1d
	nm++DpqxCFD7mO2s9hBrmBiPhZENbsbBlL+h/+DT2+sPt4etWirKlvZceI+C3zAYKYK7i0/mz+V
	wtwzJXYCZ3EfYYJ4cbo3b3vbU4qlhNlhsVsfSl0dqNIlJMvl/HvJ06ATTUXH+aGZvv3NN4Ekv2+
	SeO7FurImMC0eGlyZ2ZHXEBmgq+TpNPuc2GYgeepucCcBSS7V3zYWYEdAScZ2t
X-Received: by 2002:a05:600c:46c4:b0:483:b505:9db4 with SMTP id 5b1f17b1804b1-483c9c0f1d1mr96638095e9.31.1772269176118;
        Sat, 28 Feb 2026 00:59:36 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfabb84esm251349935e9.0.2026.02.28.00.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 00:59:35 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: vdonnefort@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com,
	wangqing7171@gmail.com
Subject: Re: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Date: Sat, 28 Feb 2026 16:59:27 +0800
Message-Id: <20260228085927.2233490-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aaF-bhAIhCgusG9k@google.com>
References: <aaF-bhAIhCgusG9k@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Feb 2026 at 19:22, Vincent Donnefort <vdonnefort@google.com> wrote:
> As we are applying restrictive rules for this mapping, I believe setting VM_IO
> might be a better fix.

Restrictive rules for this mapping is a better idea, I agreed with it.

--
Qing
