Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7992D5950
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Dec 2025 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764822889; cv=none; b=nZYPRSb+cj1qs7Y/NqCvSAwJZGpcBGAnKiqPwbW8Cb8Uhd30Mr730jTt7krfdxsySxHRV3iNqxfd11RCOUN1McHnh1vFqhWUOeGsH9ivsXauYSFeqnNBBQ32TtQuOl4MNW9bqD7ko3RJdvnLrylAqm+yzf84UJOwiF+FsfayYTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764822889; c=relaxed/simple;
	bh=GgCOziep81e/EKJzhQH5y0QjEZ56iWmp92jKRaM/sWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ/RxTihHa70rXHvq2GdcWXy1VrovGUgjKPD1cYKmqW/LiRxTFfbdJGPaKEOzA45WXKMc4SLQH478f03YxR45BOT/T9ryk9+FZnjmCdslsgx+b9gCwEN+Cg9ev4uGs/XywI1fWDIYKDEEhUalVmT4xsYC27udefJnn8aM8s27BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgarnY1E; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgarnY1E"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f97c4eccaso388431d50.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 20:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764822886; x=1765427686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOhogF/bEKUSSSKE3BIN5Xdxnrm5TbeswyD2/DYOGps=;
        b=OgarnY1E7Gkjw/DevGDJBFY0b8v2+sb6MpJxurlwKQgaJGm7hQqQSZzeFiQT+/ysq/
         8m2dbJcKT4kXSHtXSXXSwmuitQuoIP957gD6fQT66xxlxaJ0/lwcnKaT/VU85TiaVNqs
         kffs+HgDrTGjeAEsRb83HDRkMtoXeZbfSlbhNXY+hpGNwAJTGXbQIFgJZPMOQWqTGG9E
         jjhiAY3KiDVr3YyDXKwKMMlA4SVbRNvC/MQjliUnstYCtSy2dAV9bMEUa6MR+AqGW4XJ
         NeTSNcXqijTCn1AZ1ak8FiT+dhg4dZ1M5oitgNZGdt0X6/EliVPeEPLoQLv8kTkLzXyM
         XIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764822886; x=1765427686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOhogF/bEKUSSSKE3BIN5Xdxnrm5TbeswyD2/DYOGps=;
        b=Udu/75ijEqL2bzMj2kbN2Xpioql2IobPy3mK6vWx3cI0x7Dc9pINWxAQc+c8uSlFn7
         iraOEbWoKmsqypz7LHRPVfMmzZdmmedhOpB2bzNn565pkiyvIuMZUO0eH/FwPGojSAi/
         K1XNpKqdk55t1JcOdc6/18pIeBbF28zflGJGa6LvoB7yOZteN8qdZyuN18rSwVIiFXVw
         jzUaj4rs2J4Pevgr8JsJ23a9utwbvoqjCNfb/AqLjmAecYVXpzy14QVvwbKEQ3CRbiyU
         1+FYto6VtFOKj7qlvkt9kM599ILcPVNJKzYtHk4agazSE3RPdDCLhWM2exJdQhTB98vy
         SNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU23eCbb4mlzsjlW+rzm1wdyoesNvSVwuVRrwH3XvSSZjmh+uuh/cGfSucE3tgfsBmruPAAJsiffnnmpA8eNZ/QXlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbatytYGWeUmQRkEI81mzM+NaJcLpgXq109cvImknCffdwMQu
	rgLGAppPEPAubdwIj/35b4J0Z+yctvHS/lVN3gBTJkxNrMI+KTu9+Fn6
X-Gm-Gg: ASbGnctWT8bfYZJ8SXgICAgsZoHpcYqmZFwNtAh3j99z6qXoC6JyfLrsy8nGlFJF4wq
	jaOo/SJ+RQKQ7KttV2qIk2VnCaHv3dbIYBjq1/QjdB5Ri5YV10ExQupA3OzXjOeSpUj66pTSyBI
	4ydu8fm7b0EIo601Q/QD7kYlvZMnpcqteZVDVjNcy0pm47X8mht/ioe2bXOZPqI67aVkUGWeOfO
	PgiE3421EielRa1aVdDy3EWix7OpvBIx4iWmkI/O+HRJgD6dh+/oHwG36/ZONAfDnV5a+O228EC
	hrd9xjJ6q3uoscwi5BjwjeCtFOCnCPP6X+tcQ1lYz0KLqnx6Ilrq1zX1kzhej+XowsTicN980cn
	m86gyAElRckf0DCubXkBqaGdAKUyGMUkABaME0gobnoW1EOV6s3oP3sRFEa871FzYnWPwV/BXmV
	ntfOp+7scOBNW3m8UfJlsL34bgMWe6zMmM7thloqZNu5POHhxYn1s=
X-Google-Smtp-Source: AGHT+IEHsk9cvyWivHQ/qdx/M0oPC+5Tq8/rSqUEJ8fSJ/n8FLJKr7HCddCe5NH32qGcbWy5RlaPRA==
X-Received: by 2002:a05:690e:134a:b0:643:ab7e:8dd0 with SMTP id 956f58d0204a3-644370659camr4211118d50.61.1764822886420;
        Wed, 03 Dec 2025 20:34:46 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f2abde8sm264191d50.3.2025.12.03.20.34.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 20:34:46 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	electronlsr@gmail.com,
	ftyg@live.com,
	gplhust955@gmail.com,
	haoluo@google.com,
	haoran.ni.cs@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	shuah@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM regression test
Date: Thu,  4 Dec 2025 12:34:22 +0800
Message-ID: <20251204043424.7512-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAPhsuW6hmKjJF5gYvp=9Jue2N6oW8-Mj-LdFbGnQVwW1bTB=qg@mail.gmail.com>
References: <CAPhsuW6hmKjJF5gYvp=9Jue2N6oW8-Mj-LdFbGnQVwW1bTB=qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Song,

Thanks for the review.

> I don't get why we add this selftest here. It doesn't appear to be related to
> patch 1/2.

The regression that patch 1/2 fixes was originally hit by an LSM program
calling bpf_d_path() from the bprm_check_security hook. The new subtest is a
minimal reproducer for that scenario: without patch 1/2 the string comparison
never matches due to verifier's faulty optimization, and with patch 1/2 it 
behaves correctly.

> The paragraph above is not really necessary. Just curious, did some AI
> write it?

The paragraph was indeed generated with the help of an AI assistant, and I didn’t 
trim it down enough. I’ll drop it and keep the changelog focused and brief in v4.

> This {} block is not necessary.

I’ll remove that extra block in v4.

Thanks again for the feedback.

Best regards,
Shuran Liu
