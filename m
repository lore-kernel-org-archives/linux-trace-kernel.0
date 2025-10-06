Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2382D061E
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765697; cv=none; b=qIpgM/qzMWkC6W3q1VUhLZ8qOZmJCAvtu+LHDwQeXPLhT0w2ea/zheoT07XFEDAForvgTO1Z2y4ZpUYJKPfB1qY5x5N25IarBwjwzk1n75BG9K36/6QoUyuf50zobXRmgW03JH3hujF1YNB50JRYl0tMD8m8NeQpefZAC7pocZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765697; c=relaxed/simple;
	bh=BUomoTM50ZpVJiLs3X6oVZX0pfV6Je/dUk1cBR7BzMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvVd8bjOODPHirGcNd0C/v4fBD3tigmFzryd3DsJdNoB6KrfHCZJRLfU7QP/pwBh9uMAo9rPI3s2oSptOINJ62vKs2WQgcFxRCszbYa8y/dTNIzvvPxBOmrnDbyxHKwhHl0m+JvUKTQce50iVm5PHX+AljDoUAPcuVrgif18rcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKp2e8Wa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKp2e8Wa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759765694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUomoTM50ZpVJiLs3X6oVZX0pfV6Je/dUk1cBR7BzMM=;
	b=hKp2e8WaF8u3olErXNHiJAXWFxOQaYfxWWmeaZTt8n6TL0SaWpCKMGhstsR4l/ayW8jBa3
	uAYG3yRU4p5N8Slg9vRgzQ8Nqdc/CTyrC41gEoIgiD47JiKYzYhawR8B9y3l4q27utPrE9
	oCM27dzuIvo+pMHrvKDpgP0h1QZRHPU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-D3t9ugIoNzarUpJgBVlJcQ-1; Mon, 06 Oct 2025 11:48:13 -0400
X-MC-Unique: D3t9ugIoNzarUpJgBVlJcQ-1
X-Mimecast-MFC-AGG-ID: D3t9ugIoNzarUpJgBVlJcQ_1759765693
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7f78d761f74so112663816d6.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759765693; x=1760370493;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUomoTM50ZpVJiLs3X6oVZX0pfV6Je/dUk1cBR7BzMM=;
        b=UJ9+imPbxdjAlCvML7g5xJdzevbA6JbMt3a+yhkJ0HIclrWHlKy/mTMFpH94dF7uVw
         3/VAMN6vtGAqGyK9WAFgBAxShXkD+9iSCn6NFQpMe6RTO1CIi5ULc0FSB1+EjrDsXAav
         ql8rHNZ35ODuvId0c62Geq5sUditiE9PKajy58B4wtukIOpgmJAqRJ+XBnViQlK1YHNM
         Ybz3HHft0C85bHFOVg4w0ZEPKQYhJTZU+pOq0ezQUsyW6aK3p5/TjbSiXP4k1J191fJu
         3kaXjfJJXCYVB5C7lDXB7hXbfidYWqOHGv39VXEqVvxHzGl80X2079nVAtWu+BU5unPi
         8C2g==
X-Forwarded-Encrypted: i=1; AJvYcCUs+ZF4huKkYmPlOPUO+1hbxpc63AaVdW33AHVDr70o5mhq6KMDKQDXMpKcmQmUBUcDC/5Jr6rsbuE8a34cFcwexGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWyeF8YUlST8pYklO6h6KKzQrABFHhNXhe27vwpGe50oIMGeDS
	C6MKW3c2P0xnDWhWXRemv32oozrUNLsp0oEKyEDL99iQQ9RIFpRrTOtwh6q3kp6t0ZBRDcVM5Q+
	tN2dFcX+AUL7eKTsLO0CndF7SkdTnNlTOJkFru1HFizaB/EdQDX6f6lffTVEw0HoxcHyWpUeqRw
	==
X-Gm-Gg: ASbGnctA9LA0mKqlscyhhr43APjFxgde7QX2Io2f1tg0ud3Z7LPsJ0cmuHbP8A8iYR8
	hn4AP2bzMEBodj3UsfawLmj3pkGOKwe5kxrmdt6p25hml2Gw8KzHoNN8M6W0n8tcUaCedyPgIB7
	j3PYiGgv8zdbqaZIuGD5nw5ocnSbABPP2YbpFeTISFAz1/VN/dlYIUTs/St9rY4zkQDc7S1UV+6
	uRvvmHzAjhlCFXo/ANJCstrOuabUnWgpb2OmVHeh3wmz0AVmh6xkmQt6oXfxDfcDh7gzYl+U5tW
	aiJBGP4eR8zrYrQ1/8dVxzhyxOiKjteHRPIPRaX3PKGswQ44z0wnmON7mb494wSGV0tUUO8gLwm
	X6g==
X-Received: by 2002:ad4:5c62:0:b0:820:a83:eaec with SMTP id 6a1803df08f44-879dc83ba80mr158372466d6.35.1759765692756;
        Mon, 06 Oct 2025 08:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfLZ1f3qpnRgTtZvkawGBLghHiAlBOXN2Q/bWoviGmMhDGlpipOxyVJQE/8jmdAneAYFG3Wg==
X-Received: by 2002:ad4:5c62:0:b0:820:a83:eaec with SMTP id 6a1803df08f44-879dc83ba80mr158372046d6.35.1759765692276;
        Mon, 06 Oct 2025 08:48:12 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd786797sm119195476d6.39.2025.10.06.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 08:48:12 -0700 (PDT)
Message-ID: <b98f4e857bf20ca9d46c8f30b68d7705e5a9c506.camel@redhat.com>
Subject: Re: [PATCH 1/2] tools/rtla: Fix --on-threshold always triggering
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel	
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>
Date: Mon, 06 Oct 2025 10:48:10 -0500
In-Reply-To: <20251006142616.136296-1-tglozar@redhat.com>
References: <20251006142616.136296-1-tglozar@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pcrBUc9Xddgn1AAksRp9sOT9Nk53Gbab5Kz5LtnTLZg_1759765693
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-10-06 at 16:26 +0200, Tomas Glozar wrote:

> Also, fix incorrect brackets in hist_main_loop to match the
> semantics of top_main_loop.

Oops, thanks for fixing this!

Reviewed-by: Crystal Wood <crwood@redhat.com>

-Crystal

