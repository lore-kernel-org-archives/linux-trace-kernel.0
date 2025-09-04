Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465929BDAA
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970547; cv=none; b=uvYpkb3TzQZOdDDfXNHCV4vj4KEG3Elwu8uXhAQAexgxp//EXkIvj7ODfha2fjxa/h9C9tyayD5NT+bq8AxbKq55fDgvgOv/NmdKXcJFmK7xfmcNyb3rpLzCSvrmSg6C525fxSnPXTLmnOOsE24nG1FiZFiTHxlyox3JZZoEZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970547; c=relaxed/simple;
	bh=MYUCsglhDG8HdWUo0q635ykcw+tWHJPhtUDyA1p6EcI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIhNLcbW6FOPxvtpmZWwAjMau1TcANk43GEehnpSS1m83yp4MNinYK9PNSH65ljW/OrobZPZGyttlwI8v9Ivv6M1UIJof642I0voAY8cVZdGKBrZFtK4PHEz3QDq/47CRPwgpel6ZpLztlhBDpD1rhUwZZx/st/bE4nOJxS9JI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcpupxUp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcpupxUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756970544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MYUCsglhDG8HdWUo0q635ykcw+tWHJPhtUDyA1p6EcI=;
	b=PcpupxUpdbEhanBI1CrCvf60Jfzeft432TDN+s6GViJRyW8UbdUEcjVLTAv8623dbiuum1
	hlqzYCOeUtROB24LVfU0Rs+6muVk9HFE/0mz0sFrL1gnhuqQJ4sLgs8cSh6Y+iGBriNEMn
	QXT2QOWrZHZAKpax1RDdZJ3KaoiP/oc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-VHnS_aoONHaUh512XVA8Rg-1; Thu, 04 Sep 2025 03:22:23 -0400
X-MC-Unique: VHnS_aoONHaUh512XVA8Rg-1
X-Mimecast-MFC-AGG-ID: VHnS_aoONHaUh512XVA8Rg_1756970542
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b85c93afdso2756065e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970542; x=1757575342;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYUCsglhDG8HdWUo0q635ykcw+tWHJPhtUDyA1p6EcI=;
        b=o9sW8qHWZy5tTbozLioVkurjwFuKe1d/16Td1Vx1pZ4AKAgH/3FNU5L5Zk6pDEmM9K
         AG5EXmYPTetRqkEBxde0CXRvr52KzT0gsFSgKXhy6sYBnJYoSTpXk0+ZmyjjgJ37/jTB
         /aom3jczRKgs+7d+Lrp0NJobuBBMo9XS7aB9vf4KCMWVH0dXfJhLqM6E3zZl+AZpYrPt
         IejUvFZ1vqCpu4W4Geoh0eZ1ZYYF0+zvBPlExUBfFylQh+H7hdJtla2xN2OYbTjV9yfe
         NujnsmGaFQRqHBbvvE+9h4nmy6lBcOXiYJptGqiFnc3hao/dPnRT43cPfnQNQBVpLRmq
         dDzw==
X-Forwarded-Encrypted: i=1; AJvYcCXlMF+SM2lZ5x4Wm8BYVCIA/pJBP/rHvXGikPst4naPyDXCyd0dkfiYaCpGn58ypmZxjepiOo5+ljuXLqDMZOr+fi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAcyzrZzV0zliSoccFv5BEQhZRAwSgpnoNBYWF4cWgSnjJIMvq
	kWq1MaZ5DEskHVErZ84ko+49CCBAf2wh1WDKf6uAhxrGFO/I9hF7ntTgV/PCDybgQfco/2ovyCr
	oFyLuXA+ZEPOLphAivQCeO6jIioEHbWF702mAKfnRz1J4/Ep5Am4TQaoskeOCxbsIMjjnAxPuuE
	xwZtwgnpPV
X-Gm-Gg: ASbGncsX9p/dLpKajFdRS/hRo1gZgnOs5kL1d9NTYLmOivPEteuuVasZoBm7JbVXIXf
	pwNxsCDzJmlzgbFBP8gef6r+z2/pnDTF2gWpZPHSFX5n1+Ez5/yvU51wGilkAhif7hsWTryJwI3
	gR06NTm+29n+Y55109zMq2+UH1fuySDyR/lQ+wajojB344KuKGMus+HZsavfPLw/PhuNC5wgIpg
	PtUzPCY3l8lZJ6ngaYQT551h108qzaBZWqc+FNppCd37y2l0sBOXnWJk2ooim5BCXHSE81TPEzj
	w0UiMvI4+TkqroMlPzRQuvJhmwG/OiVybo5gZfs1g77kL5Yw9iLy3QynJ8apCOFEjw==
X-Received: by 2002:a05:600c:1f94:b0:45b:772b:12b9 with SMTP id 5b1f17b1804b1-45b855336dcmr152014405e9.15.1756970541778;
        Thu, 04 Sep 2025 00:22:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5IE05YERbfqfclIUz6aysOYULaVmNl7l2xVgtW8r1ACkXcEWBIgSqR+tQtvONWzv58a3WHA==
X-Received: by 2002:a05:600c:1f94:b0:45b:772b:12b9 with SMTP id 5b1f17b1804b1-45b855336dcmr152014135e9.15.1756970541376;
        Thu, 04 Sep 2025 00:22:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd063fc8dsm11052715e9.7.2025.09.04.00.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:22:20 -0700 (PDT)
Message-ID: <2abe62b06e114b7a5817dd02a0bb5594257c87bc.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix missing mutex unlock in rv_register_monitor()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Zhen Ni <zhen.ni@easystack.cn>, linux-trace-kernel@vger.kernel.org, 
 Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Date: Thu, 04 Sep 2025 09:22:19 +0200
In-Reply-To: <20250904071927.m3sY5lso@linutronix.de>
References: <20250903065112.1878330-1-zhen.ni@easystack.cn>
	 <8fa89db22320220e1bc411ded115f0a40097f961.camel@redhat.com>
	 <20250904071927.m3sY5lso@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kJ1r7XJZd3oLQv4juvpQLX_BUi97Pcww0SyvgUnVx78_1756970542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-09-04 at 09:19 +0200, Nam Cao wrote:
> Am I hallucinating, or the fix tag is already there?

I should stop doing 3 things at the same time, my bad :')

>=20
> > (Adding Nam to the loop, as author of that patch)
>=20
> Thanks for CC!
>=20
> Reviewed-by: Nam Cao <namcao@linutronix.de>
>=20
> I have been debating whether we should convert rv to use lock guard.
> Problem like this one is a good advocate.

I'm totally in favour, next cleanup series let's say.

Thanks,
Gabriele

