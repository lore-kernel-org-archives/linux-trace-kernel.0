Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EFE2D63EE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674809; cv=none; b=ueRzfEqwkPL9xmrj2gLgiPyJSh8kCdVJQD//ZD8IDqPxsIg0LiUDpnrY0r9BwObBs/pbAMSd8JtAh/weP+dOVRK24TJCmOzFx/LlYLWMUSjbohOyGE801OIF8Iky7eyqWrP7j8HkKNswJmb22u2k0mcVVO3gSocZ1t+QcMS7UeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674809; c=relaxed/simple;
	bh=ZuX2HRuY540gLLn3OBzHXp4J6+mRpc3xLSPypfFFPPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8Rz8PHeoiBpZyVYyxxoJHQfsIZLov/BTNbCZ2vEtO3O7rw47QeGj0rI2x2uE7Igq51sSochItH6bzACGfbzcDZmo7aVk8zNpRKdPEcqgIis5AEFtXxocfxqooxHquBK4gFPYz8T9gcwbk3d5UZ7V5S1cJ0zF0djRkzhbfyas3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W1rhmHN/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1rhmHN/"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-333f8d39e94so46940001fa.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755674806; x=1756279606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuX2HRuY540gLLn3OBzHXp4J6+mRpc3xLSPypfFFPPU=;
        b=W1rhmHN/EfUEv3Oh4CjZm2N3JxzCZz3VHoZQsUaJ76sEHeNb5EyB/i2Y5Y3v5XVb4w
         ubBbvbF7IS9oDyQ+dV1Mvqws7yz8vgalMEL6ZS5x+ieo4wlYNPJu9aLNOKLGJ/uiU0Ce
         N9HaIQl1B02sd7KXfpgCpU0w6MnWI5AfjTVgqd9kKf+BuSNyHkDsNnI3C5Cv0iN8pvq6
         XaA5dUnmzTFeqZmYcSnONBaVjexY9ksXWXQIWleXrWOBL1fSuAQV/PcB+2pHreBXwhD2
         fwLIIoSqW1aMk1FmQUOgpnxvtLrFb7q1y4PluKVkUCBiVG/LuGvG9yA3op7DsC6uN+Oa
         SxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755674806; x=1756279606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuX2HRuY540gLLn3OBzHXp4J6+mRpc3xLSPypfFFPPU=;
        b=c2/EpW63TOqf4eawAbmcc/2i78JI0gq+hpEqLiyC8iKcAsD27ms3iN6gtCgLB7ntnD
         3q5Z9snQIxRrZAecZB5SNbTHZcAMJ8XzbMQnzrXyk09XOhOXIuqLnqMvVyi+rnm/jb91
         MhJeN+8zrgVDNiw8vBs1pO0pi9pt9B7dAPmHEfnfH/3AkAzwH+/P8pxgl+v/kYasP/Wg
         2jF2AenCG0v7RGMiTX2pjZB8cyvj6Yk8dftEs1hW7r0MTNJ0gR/AJqDuYBBApkrZqaSe
         qTmZZ8NMugFA0I5UBD2MOYZTo9j7Zbsb/HvTiS83jvhIizDaPA6dWduyCHNijmIqCn+1
         IX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN0sZNlPuUziMgTkSz5tc5PdzMNHdEyWvjHNFl4q1pW7WgtfCJ5B40Y0MHJtsS7ROp4Efep0R/soDeN0GQEISIRRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRu2XFqYc6Y4a/85jVcjTSkUtq0NnVnhC9lwsN/yEstq5jsI8H
	o1oJrPBWYqpBk/x9DBEb5hjMYwxBZ6+TiCAWuqJRU2YPK3zTpxaBCzA+8xxqEWsdve2rH8B+XXH
	Z1jrObjVkM82YQU1fD+Zd9jg3WOn83IADwThDDEgfrg==
X-Gm-Gg: ASbGncup9Es0hSsqVjLosltVVugDCLglidomNwlp0TrWKYw72GFS7Vg2bGhhlDhymDK
	5Lahaq+hTmVPIGYJglVXFxPvr+XVEhROgjKIkWkhs6cD6OB7cv4d9YALycXAckYLVtx+KD3+jG5
	bolSAy6iR1fyS55NaOr0e5YyUjtCR7nqE8kkR8qbGIfEchSr1C8NXu4Zp7S9PDRdBtKF7DGx6FJ
	PHwYylUk02S
X-Google-Smtp-Source: AGHT+IFkIVL0QsIdOZQlW0D+lgAA1nsGZknVFkVpqjaB4S1VwEZ4JXZCYItH3d8xt7tCiiSuJNsOnXUlgb3FzUcPr1E=
X-Received: by 2002:a2e:be22:0:b0:332:2405:4d13 with SMTP id
 38308e7fff4ca-3353bea0a8fmr5933501fa.39.1755674805791; Wed, 20 Aug 2025
 00:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818103931.1100084-1-richard@nod.at>
In-Reply-To: <20250818103931.1100084-1-richard@nod.at>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Aug 2025 09:26:34 +0200
X-Gm-Features: Ac12FXzmS-9yGVF-QG0jps5D9FFgyHp9dtJtJ14yfzuuesjlk_IGoKkXWSgMngU
Message-ID: <CACRpkdbwUU5TmeVhcSAZ_ZaFa5nGVtyFBjNXBwNMC5y38heELA@mail.gmail.com>
Subject: Re: [PATCH] ARM: ftrace: Implement HAVE_FUNCTION_GRAPH_FREGS
To: Richard Weinberger <richard@nod.at>
Cc: linux@armlinux.org.uk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, ardb@kernel.org, ebiggers@kernel.org, nathan@kernel.org, 
	dave@vasilevsky.ca, ruanjinjie@huawei.com, liuyuntao12@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Donglin Peng <pengdonglin@sangfor.com.cn>
Content-Type: text/plain; charset="UTF-8"

Unsolicited thread intervention:

Richard if you use ftrace on ARM a lot, have you looked into
patchable function entry as described by Mark Rutland for
ARM64 in this talk?
https://www.youtube.com/watch?v=p9cqUTF4I0w
(Described at 19:12 into the talk.)

I think it would be neat if we could do this on ARM32 as well
but I do not know how hard it would be.

Yours,
Linus Walleij
