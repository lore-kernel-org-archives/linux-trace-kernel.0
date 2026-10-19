Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443881;
	b=YqfzcVuA6V/XBVcQFHsuR23BKwQCYX/86UiYnhJ1SyD+9pbCn7lB12qvTj7qNxTJOsqo
	 fHcm/zQMaZHAO08Kdq7xnDtP91tE+KsMsLGxwdaBMQDxTvassiiTUovf8Hd0nHgEIBNU4
	 5dOVC5vkRabi74ljnpd10hBrxMfW3oiFHOhyAKLoXLqnoXemjAAKZj5hAecXJajWsGmjH
	 VLe5kRcyQgsEretNzgphGlRGpRrwi62zQySD22+LLFD02g8o/4uiHzW1ihb7l/vL0f7ik
	 4MtjEdFBEQmxbvAqPgKUFTGYK9S1NKWR0TEj+yC3GvgziEbQZHtolzWA3FyKjSoofbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=M08jzXVRcq8BixAempEQDIhvMuLNwT78uXf1fNjRNEg=;
	b=GxpMgzX0mdHvk38Rh5peQsDLtj1tvtu9seL7Ohq6fthfyB16Hho0HnsAHW3WJQRFUjUo
	 C+EfPeRALowoico3MRP2re3rNh0MKXqFyjd4J/VizRwiKoPkEIVcPIJntnkLf/7KL1j8I
	 L01IZkGJi4FepOePuRvVEN1vASItUCKbRIYce0v0Hio9vCcyQB0BCkoWafEkSIPi7Xq2d
	 1Ap9STWc2sYVkoSB4u5mnTdV+QDRAcF1s4i+eaH8KvYe04DEG9QJAubd0+nHp1bb3+YB4
	 QlEGmF7nQwFHwpqddJN6PQ21YXlLe/1wkAty9SET8GrJatHbyKSLoCGJnMGgOZuzYcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=etKJfmI3;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46AE606A31D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 21:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C46AE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=etKJfmI3
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so11300195e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792443879; x=1793048679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M08jzXVRcq8BixAempEQDIhvMuLNwT78uXf1fNjRNEg=;
        b=etKJfmI3pz0RenGUk/EVsOjQmVpoAYeQpwAOQ7Ey6s0WuKjDC55D4E3tv7kypdmF13
         cIltavdc2mIGVC4maS9QK0ttzOFpuzi4ZJYx4JD1jRG5ti+IbjOjz8DJ5mm6Ki8K1bY4
         f/q+NsnI2c0HKhBfz/N8F0rN30WoLJ7OW3JDareLSFeAqwiGMFJWKV+YtWyPdkWo4+fp
         qs7+wrQkZNki52j/qK6KPgv4yZCS94fDPbB2laHH1QEwYPoCEuYIYTo4R9Ka+DEHJrWe
         FoIDC9k7r6QJrEDV1W8so1qkEjR4Tw0Ziz/OwlywoSQDQNcRKpk3ACFG7OxTMz8f9dxv
         uBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792443879; x=1793048679;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M08jzXVRcq8BixAempEQDIhvMuLNwT78uXf1fNjRNEg=;
        b=NFPF7eqXsKH0NJJZyU1UHajqWo4HpDQYpBRLbBdNH8xgEY5z9+aN3vi6oFc0uaAdU5
         Wv0c6B+cNwYvJxRo4VCGpMTIq0aKMrYCr58JjX4qkFQJMAPSXySXtckXMlTSWiD55m9X
         Ebn+NohseQnYsEBfwhvDWbl9VNKhktkdMRawP7H8XdrkrR56FgtNev2tmc4M9imswbus
         iFe3IAP77uzzwV+kArDIeYk5VJsFWTJ7qefCdnOyYtgK2rgGl4JjRbcS+cDR6sl6l/De
         aynlGJDI2YsylpX10rze6wYHnFh4jBQIRIiqqn9mwGo5bLf1u+t4vI4QSnKJ1YsawS18
         fpIw==
X-Forwarded-Encrypted: i=1; AKwUvBxToh/R3pWc42AQCaX1oK+GU3ljZUdqGF8Nv9V/PuIsJY/P8Ya8qHu3wdlO5u3fZ4cC4MRYVnWJsV72RIF/g0eIGFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIInXZgDZLGtfY7P7MOpBlr+ZlkxAVS1R5UDEEpYjnwj9ydFCdT
	1sn+uJa9rtqtsPFPs0E08/FWFm8E+f1eZ4nvZbTttmsVG52ANWrulYhb
X-Gm-Gg: AYBFou26VWm2Z88zp21t2X+moL166u+FwCY5iPpC2fwujHHdeOGKAbc7IRPfJRO08VB
	khUbLlhj0z6i8EcVdJoxVdyS+4wFs3Z8o/Q37yupPbWPnTyMNnlzaCb2ATmGHqq297/9SoQ4Z0/
	T0yRM6foQwGqIbgjjR8K0LJo/5Fi5meY6jJ1Ec5Nf5ELRQIDWwUCAbQam5ufCLv3JFUgLep8S4g
	QOxPXTPSuUT5FUWUSFEGCFCljXIobHh45tLTRZ2Lyb7mrpmcwV+NGCo2r+rGWEXVAAAkBMf3kzy
	7fHFTGpY4gE5tO5HY2GarCVaPkE+S8k8aL4VlY2r3h9FojCbFRKBcREY8vq7yuDWjrrSZHoBoWJ
	3/hfDqDkOdwmQwL+9+mwaO3vegSTx8OX5oVCN16LoVtFKcgs5Qv6/DQAuR+9LaHqdiQwvhwHVnh
	CSezmsQIpcxwE6cm043vQPQjD2xQ2eNWzxKZ1f8W3PsyTNRrXLnFC1iTOEyNPdVFfeC9X1rNu70
	cGNUynlLBo=
X-Received: by 2002:a05:600c:608e:b0:4a1:e08e:46b5 with SMTP id 5b1f17b1804b1-4a1e08e4871mr124644295e9.16.1792443878968;
        Mon, 19 Oct 2026 14:04:38 -0700 (PDT)
Received: from ADRIAN-PC.lan ([171.22.87.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208e0sm1434971f8f.36.2026.10.19.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:04:37 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: Re: [PATCH] tracing/osnoise: Add __printf attribute to osnoise_print()
Date: Mon, 19 Oct 2026 23:04:31 +0200
Message-Id: <20261019210431.190310-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261019205344.190022-1-adriangarciacasado42@gmail.com>
References: <20261019205344.190022-1-adriangarciacasado42@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Steven, Masami,

Adding Arnd to CC -- I noticed in Patchwork that Arnd previously sent
this fix in June as patch [2/2] of series 1104700:

  https://lore.kernel.org/r/20260602150904.2258624-2-arnd@kernel.org

It looks like the whole series was marked "superseded" because [1/2]
touched lib/vsprintf.c and several headers across subsystems, so this
standalone [2/2] fix in trace_osnoise.c was never applied to
trace/for-next or mainline.

Sending it standalone here so it can be picked up independently.

Best regards,
Adrián
