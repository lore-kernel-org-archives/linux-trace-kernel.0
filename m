Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E441922D4;
	Mon, 10 Feb 2025 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187959; cv=none; b=XIcG/Ofpq21+jANzBe/yBU4GVHTXt+gjgyLA5lZlF90QD80Nfza07pXji/jeXraAk1eu+bOgQHQsprZ6RBn9FPnHE+WRZukMfGqsQSg8xVFFGAcNuMcv+KL7rhmTaAykU2yDpKzQYYlTJhmoo5lVC9A7nYERBgeRHNAynRfXuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187959; c=relaxed/simple;
	bh=lWXx8prA/NBjWzBuLLgugDFSdc5mn/jQ/gQCvAQkjhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=peN2VRvui0lcxeagGBh41u8W9cgZrWBX0gONN2eudyPKVibf700sr6P0J5Y8mMrVt0qSNS7kt6Sih9J/PpE/D0pGZl9p9wfN/qOIsqT7+wKRtwdYVyrkPt20hhKvYbrCUprEuwSToub50jBVr2UsIgeaNhsds5EBVGCffWp/9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/wpT3h5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/wpT3h5"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so3171144a12.1;
        Mon, 10 Feb 2025 03:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739187956; x=1739792756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywUgTGj4yyfTwJSjQ0U3k2pPW/hpZaWUQlC1r5MKcBQ=;
        b=g/wpT3h5fXc4BytulqRdy3mk6o5pg+u6i/RHnKKgy6qUfuVYLnvR7CBoF/VUZj/qQI
         e0qSpvVVZjMrfjEzNMLLg8EWSO+USsGS6ZOWkLCLEdUaOohM/OolVNmTBdUnEyjZGF6D
         Pmn/GvuunwjiDGmRtC3I2VQseNZqeNooCgDljpFlIAjb93ywml89tRvHFivs/y7gjMgQ
         2fp0nGoLIgZyI1pQYgOlQOKkA7Owe/28dZQwCu5CKnZ0vQoEIxrDynLG+i0Fgymb4AK4
         rmJTcFU74FMwlAnGukxPlr4hTMYKsfpdm8LQmAAGHhy5UqLw+NcJ/KUBUEqFzVSa1oTy
         cWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739187956; x=1739792756;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywUgTGj4yyfTwJSjQ0U3k2pPW/hpZaWUQlC1r5MKcBQ=;
        b=P5pR0INm3ONV1UaGQTK8iBVg/BCQ+N/FvOgx7FsIsqTjMbHSiKS+3NG4LfnXeOsSJq
         T51f1EqgMu5i29mIVKYVRcnCajwfzlb/wsKF0Lo9VxzyDrA92YKuUNJfWHCW6iCNckS3
         gdQkf/FheCsMFfHnx5Ze7rsvsmd+d6Cma6PDm6AITRDY6jOQty13uN448djoFH5F+Im6
         KcyVC8tw0W8KsehFG9qisjKygUAR1WP47fIL+aycsdbUXBTD8KOwEsQ6JOLZDqRjUD/t
         QMWUi+EXqjqrQIGzsLrctmU4/tOTxaVqvVddWTghBaU/CNhFzTU8axfQacETmdIhTMNw
         zUTA==
X-Forwarded-Encrypted: i=1; AJvYcCX5x6NFmjXSrk5QyxTstA1ZqReWknVcxvJ3Z+peQCLkOknUbHssYUJa0y9Vf1SmJ5WSCr4lWk+VFpdOFDHSnzTWD7FN@vger.kernel.org, AJvYcCXduMK8G11rp4IrKz6ByUPA5wkk9DH23oTbk35mxiJq/6JyabFv0Y0c9c05fQpeqbECnoV5pygPJJfH@vger.kernel.org, AJvYcCXshsUhbpW6Kq7nb5aAPMcZdn1cueEjPE2kW8wS4hJIRXIRlz8jdg10BTUklIl2sTlau/4/xNpT9EdJmdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxgYG3ildFkPoutG+VZv2icqkeuIgj4NgJEDdOqa7gMj1mVun
	DVbyau2EpV0SqaUFGDzhAkKxKEWANkuH/dnOXR5pg2v/TmlS1rKF
X-Gm-Gg: ASbGncsQFK5hhO7hl7ZApsUWhCbsbpXnf8ZEC3bobkIW1a3in/yzx0cj0dyU6SLz8Va
	QHvaR1PDHCGLZs/fk3FLnLHqlOBeMI7lbF6xHagOgXiYKk7INk8hAqVILNDriQYoINVuDxHMJTk
	t8T01qX/babYfozVU+HM2ogg6kcorkoppnogm6IgjHEuJEEDjlSMdHv2xHc8ueW/ZwN5ZrEqIwZ
	J1QwIawzZ69AjXJSDUQFYHVARwT1f/Bc8pltMs1Phadj8BnQZEuddfXVffO7xwG+Iz37HmSSLJZ
	vdTeKIS2BvPBVs2e93dH4PSSXpZNxgHR
X-Google-Smtp-Source: AGHT+IHLY08dXDofAVx8vtXsHvoOSVRQhx+tufolp2+U+l6VQVn9pbl/alQrUPQYxtq0MeD47nWpvw==
X-Received: by 2002:a05:6402:2802:b0:5d0:b51c:8479 with SMTP id 4fb4d7f45d1cf-5de4500490fmr12517398a12.10.1739187955955;
        Mon, 10 Feb 2025 03:45:55 -0800 (PST)
Received: from foxbook (adtq181.neoplus.adsl.tpnet.pl. [79.185.228.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b7ade9sm7744166a12.25.2025.02.10.03.45.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Feb 2025 03:45:55 -0800 (PST)
Date: Mon, 10 Feb 2025 12:45:51 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: pmenzel@molgen.mpg.de
Cc: anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Subject: Re: NOHZ tick-stop error: local softirq work is pending, handler
 #08!!! on Dell XPS 13 9360
Message-ID: <20250210124551.3687ae51@foxbook>
In-Reply-To: <9d056e62-4e58-40d5-9401-40d3c20c2389@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

>>>>>>> On Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, with Linux
>>>>>>> 6.9-rc2+ 

> Just for the record, I am still seeing this with 6.14.0-rc1

Is this a regression? If so, which versions were not affected?
How hard to reproduce? Wasn't it during resume from hibernation?

IRQ isuses may be a red herring, this code here is a busy wait under
spinlock. There are a few of those, they cause various problems.

                if (xhci_handshake(&xhci->op_regs->status,
                              STS_RESTORE, 0, 100 * 1000)) {
                        xhci_warn(xhci, "WARN: xHC restore state timeout\n");
			spin_unlock_irq(&xhci->lock);
                        return -ETIMEDOUT;
                }

This thing timing out may be close to the root cause of everything.

Regards,
Michal
