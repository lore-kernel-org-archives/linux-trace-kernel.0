Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126F19F41D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966447; cv=none; b=WPec117JCJC+81QWBqsG0YJuW2N/DSqMAXMQ7GFuSljAVmXnQ86KdBehIBxEthLnEPanybUvQ8x5vgL2QTJ8ilZNR8nT0QSeK95eh3fLB3lDIyYzD/poPbQfo4Au5NtS0T/ETU2FtuJhlI5+pL9ThOfxs67u59ft5csWbFNh3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966447; c=relaxed/simple;
	bh=rkCYpA5/6HyvgCk0Q1kSIaS7X4hbRhHrd+naSGckOAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXZR7VIJG4NVvh2JLQ/9AwVVEIiHJzSMS+cVYmeDy8Nsyh4RzxnKhhr1wUu2XVwRG6e9Zsut+PNYl9inuRB8+YT+Ua09TNFto+AmORSkTwOZh2BXWRHMa/UHycbsLXmTLuXVEXjeEGdx0MUimjYRhRs4ShBR1rbg0WUmNM1DBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XmRrfdbN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmRrfdbN"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso77576a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 10:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736966444; x=1737571244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bMntqLLbRnNm+8V16Mvxg5kR3zMbyGJQK/UUP2AtJg=;
        b=XmRrfdbNE5JpyoeJLZbVs6QeNAiiYmBan+LQutvHNQeIW0OoNckhEglXfA8uQAsuLL
         liyc02k40smhsh4/6xFzxHj5vw0MCnAXko+C41uthM8UWJtknmexTFbNL3Pprz7IlBCZ
         2ztnbf4ipy9ky8LrdgRnUCXEo9t9EJdQu/BIZKfAoZYGaUV8dvJE4AlkwptT3GBM3oxL
         JHJb0eFwWWyE8TrhX6e0cWLnMBN2g59LB4Dm4hvqXVU5qvrNMvr4Ua8JAYpsLNK1GbBJ
         8WAO2dqcE7mevgHvMkzQxdc17BiclrV6IyEc9HwtWXgfat7Y8Z2klwYJ5lIFawKj1sPV
         XucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736966444; x=1737571244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bMntqLLbRnNm+8V16Mvxg5kR3zMbyGJQK/UUP2AtJg=;
        b=OxHZHLVPnbtiVyEaCA0whsqUY5+w7pn8oD6WmwwYAp3o9tOVe38TL853Aja7SRy1/b
         WA4Dxx3YPWjjy0STkBNahsL3/PD8OosX3zNVOQkKmJ5O7esolm3iYG2GxQMK/w7y803R
         CMd2oX8iKMKgWx4JIrHbNawWvTZbMyKgVe1E1wWQM5BZpoJeZX3XkaecX6qi2UQCG3c0
         DD6gyEPgUrBB5JiCIZgkLVvDxMQeNnGm+OlTDKz4DTHZDCLMVlRlJqwIfoFYRP+qH1Q2
         gl60NC/jK3q4LBB922E9b57mZliyGiHP7EABEMOKm1vCuwH9LbEYPnBDj1Aj1x2chECS
         apHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXllMFXIWbccVOhtCAv17eo6T3HyYILH0Nvyhlm19zKlz5+TmWDAPg6EbidjW/RWqu0lJJYqWy3fbo3ATHnNu8vv/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3k4owfu5mE7RtrqTE7J7AV5MCfZ/IFMy95qbqKILgGt7hQ2R+
	yMYpQMGQx7sr2ZpI3PT+v9Cf/OsoM8KTQME1aDL40pHqVk9he+Y+UcJTHMGRH5A=
X-Gm-Gg: ASbGncuDZTbT+FALygXYXt5fEQKrIRRMDr0yBqhmwtvS/radN4YAbxNK8/fkoiG2J/t
	2a476lnMq9+Vug5+5H1xbir8NWiOr8hj09hzINAxkThAGrhcmxHfuJTjc8QPKj8V9pn3MssRCmm
	vf7Iw+7m3Bp011bvSPQpp8MwmQCjzwFEXv1pzr42a6Sw8QVIX+id2AzXgZE/+BkVOS2i6f27uvI
	y6We8k0j6AyvuwpIYC8dFwwBe3rLUzH6Xf+TrzSOCjHOpiiJI0V/vQHzmeTxQ==
X-Google-Smtp-Source: AGHT+IFEhu1Ze7Q3nWToOqZkmLGT5dglBO8lGamc5A7N+ohPNWaVdIrUEnpC//b/4VgLC1z7cN4e6g==
X-Received: by 2002:a05:6402:270d:b0:5d3:d4cf:fea0 with SMTP id 4fb4d7f45d1cf-5d972e4c62emr25697586a12.21.1736966443924;
        Wed, 15 Jan 2025 10:40:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d990469e5asm7805305a12.55.2025.01.15.10.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 10:40:43 -0800 (PST)
Date: Wed, 15 Jan 2025 21:40:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tools/rtla: Add osnoise_trace_is_off()
Message-ID: <099e9ae9-5d36-46bb-8790-1b6a33dc1448@stanley.mountain>
References: <20250115180055.2136815-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115180055.2136815-1-costa.shul@redhat.com>

On Wed, Jan 15, 2025 at 07:58:30PM +0200, Costa Shulyupin wrote:
> The original code accidentally works because offset of
> `record->trace` is zero.

It doesn't "accidentally work".  The people who write this kind of
code 100% understand what they are doing.  They don't see it as
anything complicated.

regards,
dan carpenter

