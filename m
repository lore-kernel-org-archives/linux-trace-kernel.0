Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC70B482EA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960970; cv=none; b=pUnZ82z6E4QU0iqSPigW+41eWEwqfgS1JO4daQD9kwlLuFPDAk7KVR3Bx9FAuRIWNveBC2tyFIzk4l75AfQh3G+xdtWIQtB7BxmAhJxWoNxQs0hhECAU/CwGIyFWOOfPFdpmVJVtmQEwIFWk2U8QwIYC8R+9XoZbgcQ7DM91HQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960970; c=relaxed/simple;
	bh=0hp4qAvrOKY8LC7aAKY29ksp0u/TQ0p/ryQA8d1FRbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBazDBIQYZIqospg8TR5LUwkNNp5P2jg+mX96f2JfAIASa5mqpLeyxzkRimQF54Vo4mKNEi8lEtYx5qocNn40W8KOdD7TqqSZn0/a2gkBHzgRulOPKgRx3SnBreisbWUvu1Ih+dzZl6gxcQ5cmyPX5btUf3+Ie7+oeAftjgqxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Oiigjfjh; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Oiigjfjh"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e67f70f34so3704995e87.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705960967; x=1706565767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jOSAIaGnjvf6CCjF3fmWDAvl/DrTsNgSFwohRJOla+4=;
        b=Oiigjfjh1FOT3dWADyiBvbCTmFIDuugvEH3QUxZafJns3L11Pt46kookMLfcfehMvY
         IRympvnxlfV6KykDmEKM5TfLsQrCvFcbhsOTugbQJQLo3gL2zc39zwFew3mQjtNwZuRZ
         xqMoofL4CzT+40rOdRkxhv9CY05jeScesslU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705960967; x=1706565767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOSAIaGnjvf6CCjF3fmWDAvl/DrTsNgSFwohRJOla+4=;
        b=HbT3EALpcEYlxcUQ+syF25km1yBSLTQXm8cRDyG0iRthYcYZuS8C6Ugy0XRBVw38fp
         wskYWAAgo7CicAzXZ66PyzH3PhRdAoYeZZmTV+ai00XR/NJsna50c/ze7M+cclJ2Mk2c
         t8xsqQ5kU2+nPn0H68p10TuJups/x0H3ugy8soTsAM12lv+5CGIGsUcUYrsYyXP0CcuR
         zP83VyQ1qJq6JvT+mhVvS9Zv2MD2XDvpa4wDNW75H0IRFH0p+X5E2aX8cpKj0ec/jBit
         3P0yI7W23ktgO8IBSzdSc+np7cfckC2ygY8M30D+tRUmvrKMC9eUct5pJkaNUG29rvzT
         QbYg==
X-Gm-Message-State: AOJu0Yx0jQZ0B27INS+XOXBomqePDznLnkuQ3PXDbt7EtvC5VnkBlZps
	K6igIr7Dt2ofc7CW0hNHMH9H4rQGPCF8nqWhxi6alqJ8ToYRKgMD5spxqZCIKB6sZyZDo6Tohb9
	MYgYXWQ==
X-Google-Smtp-Source: AGHT+IGL6+zuJBpa4n3sRwsJQpRTUYK+GLsLLLXuZUEoQbtZd5J6aHwT3hEX5txdYuJoODNkufa6Og==
X-Received: by 2002:a05:6512:110f:b0:50e:8097:d51d with SMTP id l15-20020a056512110f00b0050e8097d51dmr1886577lfg.33.1705960966710;
        Mon, 22 Jan 2024 14:02:46 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id fc21-20020a056512139500b0050eba4e0eadsm2093840lfb.90.2024.01.22.14.02.45
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 14:02:45 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf108d8dbeso119251fa.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:02:45 -0800 (PST)
X-Received: by 2002:a05:651c:1a25:b0:2cd:f914:bba7 with SMTP id
 by37-20020a05651c1a2500b002cdf914bba7mr2536886ljb.34.1705960965293; Mon, 22
 Jan 2024 14:02:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116225531.681181743@goodmis.org> <20240116234014.459886712@goodmis.org>
 <20240122215930.GA6184@frogsfrogsfrogs>
In-Reply-To: <20240122215930.GA6184@frogsfrogsfrogs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 14:02:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiODW+oNdoF4nMqG3Th7HhPGQNQekDvw16CvgKvaZArRg@mail.gmail.com>
Message-ID: <CAHk-=wiODW+oNdoF4nMqG3Th7HhPGQNQekDvw16CvgKvaZArRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] eventfs: Have the inodes all for files and
 directories all be the same
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 13:59, Darrick J. Wong <djwong@kernel.org> wrote:
>
>          though I don't think
> leaking raw kernel pointers is an awesome idea.

Yeah, I wasn't all that comfortable even with trying to hash it
(because I think the number of source bits is small enough that even
with a crypto hash, it's trivially brute-forceable).

See

   https://lore.kernel.org/all/20240122152748.46897388@gandalf.local.home/

for the current patch under discussion (and it contains a link _to_
said discussion).

           Linus
