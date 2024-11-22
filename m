Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E66FB9;
	Fri, 22 Nov 2024 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732236186; cv=none; b=eAKqhN5TnIG+cDnnflo20PwGHehe9n2IwkRe7kFH5gEBnBleFUANJ8UWgoMRKVEcYzt4tCmYHILP89l8I0CDI2nT9KdqN4w5Z5Ik8+AscSLlwopT8osqpkzpVqI4Z1zo33ySrt0z4vQBWTGnv6ApoQdmQlXPzd62Fp9EZuUKAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732236186; c=relaxed/simple;
	bh=Rqb15WRPH5MG9UzXeqMKOHd/CMRaXCuz63iXSghhFw0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QxFa3YvOgDQrnV1SeXlUtvnigeRBuvvAfYW1qNPDg8KKnSyAhfhceX+rrnCx8x9VHO47YNfyf0W/skDsGA5++B92VNZc2TfaC+g9IgrYvRrt62SsFtbEebAno6ATYUA5NBTV+86e398yzZoINWtl4W/JetggwH5HpQlWJYA4zj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXn344qU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXn344qU"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a850270e2so288212966b.0;
        Thu, 21 Nov 2024 16:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732236183; x=1732840983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CO1sqiSTxqURH9+vvZf8fU5qNWSGbysLDKpYNcP0JjI=;
        b=EXn344qUYZMcJrYA1MGfL1WSEBPQXawO3on6qjnyju8/paAsH7zzNkmMrTfzQLY03K
         7EaSPiXaE9m+6msUreKRwp9QTbDbm7mNpu7lAS8Kmp7aCDSmOGk5lS+UL1R9+DEYRtlA
         nBM1SuezKiX9Dzaxlkk/KPK7cuD55DcIEvElIbhJDSc5dnYLyChZED37n98nxW1LrwRO
         nOTUeaEZHJ7WPf+I8Ag5gi7KfBQz2vVVdd9jOox25T3KAoPesdIpKLCmsy2LDH7PHCEq
         c43T2R2bQNFMLMxpGD2Ms/HnwZktmptG/UYs6tXWVgW44HWuZ68bjp81bgEfLeusik39
         DIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732236183; x=1732840983;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CO1sqiSTxqURH9+vvZf8fU5qNWSGbysLDKpYNcP0JjI=;
        b=mJ8kL4l3h5YjKEUbVlkmuPkjEqwSsVWgDVAjZp/dNyuiHj0e1P7itPoQPSK/QDFid7
         +fb9j037eAYdBiAwqaMyvF/ZsVv2EDnlvbJjPw2Uvuwqmq9/1RzdASmPEEe9S5G8qyJZ
         a526GxYIoaMOFPWXXRQsdm5KF/FCY8fEWV2SyeCFFLRUhpbNvIPZOi6SLaZ22K+ffuJ3
         2cPi1EhBj89Eb+TPPHcnw4aRaanJxriCtt83iF3qSOTKXdnCPSP/NysHLwoxMAYsz6T6
         qCvwRxEaBjKbmEjptr3Q/E21qLXYMauyJp38HxPuP/mxgAAOP5UkPnOWNOD0tMUCVjiJ
         GNew==
X-Forwarded-Encrypted: i=1; AJvYcCVZtw4Wz+FIZy41wrhwebESa0fxj5EEtp/7un85vjRWA3zT3NJwiQIWpTI0XmcEs8k7j+a1CHnpHKrzB+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYv5Eoovaftgc4uw17iQdK0BTlV5o7Jp1qryHqbvPQ70/2Ovr4
	vuUrsKa+fnLsWHE8Lr0zoJeeODdndg0nj3AyFJiJWNxwHEeUSoM935CMpd0hDPvqHx/T6R51e50
	6zPDsQpOJVIFUfT7aj3s5ee4dIfy023XWVY4=
X-Gm-Gg: ASbGnctnYUoqxvtwAEnIbIw5qL0/DtkjNQEa7t/4Fup4GWVF9iKZn4S++VcdVmKG7OR
	ykUzhwKOEcUrN9CpBU5hdXKhZKjSWH7JCYRNQTbAq3Pwwgg==
X-Google-Smtp-Source: AGHT+IEUgcc2KaNRc86MIW3jqTKtK+v9yxm/Ui2WTerCR0xgcXQ0TPlNtN9Jgg0JaWSEbBiZeZPNT6wc+cpnQ0ql7dA=
X-Received: by 2002:a17:906:311b:b0:aa1:e04f:e339 with SMTP id
 a640c23a62f3a-aa50990b1dbmr72118366b.7.1732236183057; Thu, 21 Nov 2024
 16:43:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yuxuan Shui <yshuiv7@gmail.com>
Date: Fri, 22 Nov 2024 00:42:51 +0000
Message-ID: <CAGqt0zxtKboY1PWRN4kCF3uTeiH9ZJtj280ARvGWeNtR_ik0eQ@mail.gmail.com>
Subject: uprobe_events can't accept paths that contain spaces
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I hit this problem accidentally when one of the shared libraries I was
looking at is located in a directory with spaces in its name. `perf
probe` reported "Failed to write event: Invalid argument".

If I understand the code correctly, strings written into uprobe_events
are strictly splitted at whitespaces (by `argv_split`). This seems
like an unfortunate restriction. If I submit a patch to introduce
support for either quotes (") or escapes (\), will that be considered?

(For context I am running something that expects its libraries to be
located at fixed paths, so moving them to a different path would be
awkward at best.)

Thanks.

-- 

Regards
Yuxuan Shui
