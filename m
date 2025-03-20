Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C342236E9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508142; cv=none; b=pcgnaydMgxR43MoPPCZhe/opc9cZwSNoc7yqL00U/mr5sYiahFkzJDtWgSxKytIXJuQUmuBWrc1AMX1c2WHX+ZjR5DAgKDWWWeGQWD8q/BLQgseraPUYYGaAEV+C4KopWCm1NNprZ2UcKKcWjr8/fQT39MZlB7mAjcUchQ25ZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508142; c=relaxed/simple;
	bh=cTDl606SdAshXgfXIPLIxd9v6lfdZ0MuOBEOH6UNRYI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mqjAKwbQMH/VLwnPYl//Mfr9rZtwYVxo1LKjSdsVVbBAfJVJ/Rni2btPAXVwN3jikDdDsopmSfOOUc+RivPEMsIw+paH5oj4iztI4lS1gq73vwi+XUz0g2tVYSupWBJvcl7aNqffCM+DGt+cMWHFBdSh99dl1031ajoHKeh7uSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=YsGBnXUz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YsGBnXUz"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499bd3084aso1261853e87.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1742508138; x=1743112938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+4Vpvh+DuCRZBn/ix37HYztXrs8lPgicnPsSqe30+XA=;
        b=YsGBnXUzBFso83KDwI69yiU7Gxog5usb/LrTfIbD2A3Ivj2QfRFlivfHfwM3f42Mgg
         wcqb17oAO5tt8YhsXdkjwD/xXdBe3KppJmwUrWetZy/nqTdEfe8BMDRV53LxteSYZupZ
         kih9SIJkqSJOZSDaoBePf+0Rs7URw6dUIs6R3xZujayFItgBYEtgfYTfBYuQFNL25vRp
         VevWXI3rynRjPNAri5QRnEMQ93YLyw1HUvl3d5UmTakPsonAPY4OrPZVE56CqAt6Ck6q
         9nNgwVI4p96ikCioHkQpU2eaVFsaZxChLte/6pEySRSMjMMIryHhud5IvoAsxlBDZTJc
         4ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742508138; x=1743112938;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4Vpvh+DuCRZBn/ix37HYztXrs8lPgicnPsSqe30+XA=;
        b=YOMv2y3XRqL25HrmA4DuUE5Yzli3U/DnvrUsY+Su+SLXjW55Jfc2BckxVl0TxkeOcu
         542iSKQz5g3mse2UeirsQvm6+GmENT85ujqriob1SQsSvMtFa6IacBqn9xr+aa33gQIk
         GDNyfj9hD5e+DuMm+5JuiiaI9C4fSscycj8UM/r5xcZyN98YVFkBD7HBqEGqPt1dh7eN
         GJHQBXr+zXhSgbzylt2atVpxCLn6kR9kXFWa7NYOwkOIL5aVN55dV/A6+G57iIBlH1Zf
         dEciFJLNjI8dG4uohrmh3/C7EDYVtt6jAmV9Pm3W9b0UKpFeQrsa5n+Tq+xNgowRZg3R
         Lk7Q==
X-Gm-Message-State: AOJu0YyHBQKoAK9rbPMraFKiapWo23s3AJNEHL9LuGkyfrmJ4ao5R3Fk
	PwYYcBjC1H4goQAZqY34f5OLje7iNDFMTcrJ90RwYCTzKhgpe9LKcSOGPFAfPNx9W4t/ZJMOFsy
	zaWwRiT1vA+3/IRdHJw9hUNWahBU95XiQ5Uy3lMd8AcrAVdypkMQQ
X-Gm-Gg: ASbGncthKnl5lfEl5LN5fK5dn1GBvuQducqTcyoV4r6phpCoxkPo70iJa8Gf8UmIrmC
	DnoHuOYPY0iOcm1KXkLjt0RSlAQn0wjlzIFlacyQpBjasun4JqtDK3WCWNJ8wPVQBoGMXmisWOt
	cVARPHqYwWt4V/gtxUNqWD70bh
X-Google-Smtp-Source: AGHT+IGjXBYbdo9XENf7HeKIma3YsHYADF620UeY3OFOtHtsx47W4CWJPpupoWWKC8cihKjp0LlzJDhG+ZZ5DtdiZEc=
X-Received: by 2002:a05:6512:3087:b0:545:ea9:1a24 with SMTP id
 2adb3069b0e04-54ad647ea1fmr330237e87.14.1742508137977; Thu, 20 Mar 2025
 15:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sahil Gupta <s.gupta@arista.com>
Date: Thu, 20 Mar 2025 17:02:06 -0500
X-Gm-Features: AQ5f1Jpi_WGvUcTS3nYYtvPeSUsI73Ncsh4vxHq7MqDnU7ZYu5ADrVkcloox-vA
Message-ID: <CABEuK16m+msavH79AZxTRSqOsS5MQmOnsZZ8tZuKY5WWwz3bFw@mail.gmail.com>
Subject: ftrace: sorttable unable to sort ELF64 on 32-bit host
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>, 
	Kevin Mitchell <kevmitch@arista.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On 6.12.0, sorttable is unable to sort 64-bit ELFs on 32-bit hosts
because of the parsing of the start_mcount_loc and stop_mcount_loc
values in get_mcount_loc():

  *_start = strtoul(start_buff, NULL, 16);

and

 *_stop = strtoul(stop_buff, NULL, 16);

This code makes the (often correct) assumption that the host and the
target have the same architecture, however it runs into issues when
compiling for a 64-bit target on a 32-bit host, as unsigned long is
shorter than the pointer width. As a result, I've noticed that both
start and stop max out at 2^32 - 1.

It seems that commit 4acda8ed fixes this issue inadvertently by
directly extracting them from the ELF using the correct width. I'm
wondering if it is possible to backport this as well as the other
sorttable refactors to 6.12.0 since they fix this issue.

Thanks,
Sahil
