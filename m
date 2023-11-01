Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924405667
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITbO5wnM"
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA9BFC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:08:46 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49d6bd360f8so2795402e0c.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Nov 2023 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698851326; x=1699456126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=corqp7CfGvUyEgrD9bIV6OXcI9ow1EsKtITC795TmMQ=;
        b=ITbO5wnM5jCLAL13+0dMybayI4hKNf4MZTGhkIMGN1kCltZOP46+fiitHtRr9Adf7H
         aK/11F/fFY+cvC5RS8QMKKUO6M2ujeLSxAZpCMxP7/xwU9Wkzlg+OwRI4czv9WGAo2vY
         HW72xWzqX2h8ROfRMQzROtSOJ0bZkjvVOpXbaBEXUNhC2st+JKYQEiER6L1cUjNlLtkn
         D3zBJQm8gO/K2GqRzL1kSSgaDLP6048XRgwKeOlCRPE2BPSp9HhOneAYo6Aj74z7oFEa
         RIyzFp8yAgCG/RW3c/fOznENzHD1eel3yeXDurJQoPT3UmyffkdtWUL76dEUp9pjsIy2
         XTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698851326; x=1699456126;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=corqp7CfGvUyEgrD9bIV6OXcI9ow1EsKtITC795TmMQ=;
        b=wci6q7EEzIFMl+Eha9w3oASJDokrwKL19K6WjcUT6XTSPjgpqeSVgrDXj4Bzek1zu3
         qGbVhdMLSrj5N1I8Yj9LxU99m85Fd7sU0cn55OCyVrX/fE1mDL3SHpF4zzUWI5mf9VLy
         0tS7j+5zDD0NBdZCloFIZdxSMllHhU9194xlQHL3OG40SlVYPkDVFe0/Re9HoAnIPP4U
         j9OLnHax+rg59a4NRfVoYH5Uj6vJaFwXPsmvdvHqwf4kqYtXQZWpGdUVzreWbLrEapLk
         /RTIf4g+Fx5jbtQKMS5EQ9HLa96JRejqthYi3IJpskskVCP9WBKX314XDAuEhjbRS67e
         9euw==
X-Gm-Message-State: AOJu0YywKw6p4stYOEjLp8GTyJ01dlQ25g28Ebhnj3dF2R5vXZ2s2RAO
	/TE/o1IT5YZ4B3EkFYqWzaMAf74PUcxve0lRA4VFJA==
X-Google-Smtp-Source: AGHT+IFRP3J26J6f2G9GoOmlvDxQMUn3GJVpErAduzprqFDcGBF9BHEKiQQgZG1z2mpFGEDO+jReHPh6OMo3irT4O+Y=
X-Received: by 2002:a1f:a047:0:b0:490:e790:a15b with SMTP id
 j68-20020a1fa047000000b00490e790a15bmr14482637vke.10.1698851325888; Wed, 01
 Nov 2023 08:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Nov 2023 20:38:34 +0530
Message-ID: <CA+G9fYt-XxvA+Fg5+htpqy8ySAtY-q+dGD_FOvmzGJOPbAySHA@mail.gmail.com>
Subject: stable-rc: 5.4 - all builds failed - ld.lld: error: undefined symbol: kallsyms_on_each_symbol
To: linux-stable <stable@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

I see the following build warning / errors everywhere on stable-rc 5.4 branch.

ld.lld: error: undefined symbol: kallsyms_on_each_symbol
>>> referenced by trace_kprobe.c
>>>               trace/trace_kprobe.o:(create_local_trace_kprobe) in archive kernel/built-in.a
>>> referenced by trace_kprobe.c
>>>               trace/trace_kprobe.o:(__trace_kprobe_create) in archive kernel/built-in.a
make[1]: *** [Makefile:1227: vmlinux] Error 1

Links,
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2XXALLRIZaXJVcqhff4ZmGTeZoQ/

- Naresh
