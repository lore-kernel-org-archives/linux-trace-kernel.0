Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726826F2BF
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403835; cv=none; b=UqR00gprXi6QzwQtXFbPE5wCD0Denyxp0ZmLEpxuiXjNJi1+vn9z5YLBSzVnbJsIXpNj7fEtwbKkp8R7A6bX8cH8ls8R9+PJs7uOh7t8BZAXCqZ4qzQJvV1Ar4EFCWW7VixuufH0Qj/P3IthT923rKsuHuwI86aVsaPI5y9jdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403835; c=relaxed/simple;
	bh=Q77oJzKKU3yE1nwn1ezBB6bK11QxjZntnGjkk9VN77o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHo1yd+iQyDYaJr4P913vBfk0PrcBkTruoaYx9DYv01M66WVqeTKUGVhMN0buVuomnT3/hL/emXzC21MBA1g9PKADuTBcKqkJix33wlZ+XubQLEcefeFj++OHelMzU99TyHxjGA2uK8l4HRIOuSLnzW52CK5cXjZb4dzIDUpmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MID6D+uH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MID6D+uH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759403832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q77oJzKKU3yE1nwn1ezBB6bK11QxjZntnGjkk9VN77o=;
	b=MID6D+uHSbOmjBVgN5tsnwUcolZCuPaQp/y9655U+wxBXbTG5hYXOi1D3F5cOA1lVU/D5h
	Rx1Oc1xx70r9DXGf2DWJG/TTa+RWu4g4eBzDHd6zRml2GRYrORIhQFatxIVpBkyrCXOikj
	KbnTffzl2kWeqRaPP1oBn5A6IRExvSk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-seuZTbj0MCeAvjBwSc0NIQ-1; Thu, 02 Oct 2025 07:17:10 -0400
X-MC-Unique: seuZTbj0MCeAvjBwSc0NIQ-1
X-Mimecast-MFC-AGG-ID: seuZTbj0MCeAvjBwSc0NIQ_1759403829
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f44000639fso535525f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759403829; x=1760008629;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q77oJzKKU3yE1nwn1ezBB6bK11QxjZntnGjkk9VN77o=;
        b=Ec4xMKcILx3J+vrx3my5v48B5vDmlHfTHi3OKRVV79Z+levn1QLe4/bM9nFQGcW19C
         Zlo61t37D7P5ZbrakiDFZjS5PhBnWeFpXzbBixNGcPGW0Q73eUWS9OoncMK1f18jEXmy
         Y2MY4Hw4Sj6xyZua4QYsaaIiHuAGnHDcpMbqdJL3FWC4ivK10rp+RMvD00m/isTDhCm/
         RDJVG3BD4nKcJ9B+783mQyllD62ilFL9r1cABAshfXUgZIol0s47LygpKQGmQ+YqBge0
         SbrD1GVB7+TCJh0PHYf5TRPYRy6qypMjkhX0RHDFWz8T56a1NrEKUwVVNxsC3Kh+GChp
         iDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrD6DmhuQonSUA5WJKPhJsE+mHf75T+ZRy3/G1utloWpULQM/i4bkDwnKuNZSLRnHomt+xTTKbvGtq7k1RlDhng/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEyPxggYqplM8w8u4qwDHfWGR3KKwePsAfD4fkvxemlRaRR5j
	+ZjwEF9evSwf+PPwVQUynyubGfohcS8wXfWbKZMwkepHXWQJuT2klnmyHXb1bCHJweg3PZ141Nv
	hSXbas2cpxSb+Xy/kDkz3Mxz9783H0L4gbyXRddkiTHlppjidV6Vrh700cUeGsxHuGANlr2Zg2g
	==
X-Gm-Gg: ASbGncuO1A2g8NV7g3+j/Ncbkh/yTK7be3bRjEi5JYHDF8+F2HiDLfcBGXP+iOI/+zp
	nmCfjQg5lb7BMG9HsJTMs6hdtwHx9pA5NPxjnIBWFLrW5thq+XZNJvWSfBAVP1gtyMjGr57J9ZN
	aq8WtWYi8+4az/TqI51omWjytdoSAM8XKXeXKSc7qt9t9ahADvTbw7ziFgMkkZcVyymmtq8fZ8e
	brY8xv3rxcTBI//eHvhkC2z85zfZzuLhDAYnBSINymOJySvzUf029HMucgdLpFswZC18Catg1eV
	1W3amuaLnFlArDyOpgGE1iKcIbR1g/8F+vC1D6AWJEFtFKF3Vy7xq+Vv35sYZE2PPnbZp4c=
X-Received: by 2002:a05:600c:1f86:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46e612bef22mr49128235e9.18.1759403829242;
        Thu, 02 Oct 2025 04:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb8dml5vciNP6tQjqRhGREi9kZK4uoaYdLf160JpRfikuws22jqCWavi5Dapn7jZSLafssRQ==
X-Received: by 2002:a05:600c:1f86:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46e612bef22mr49127955e9.18.1759403828766;
        Thu, 02 Oct 2025 04:17:08 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e637f7c00sm67120645e9.22.2025.10.02.04.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:17:08 -0700 (PDT)
Message-ID: <b2eccf79b5ab2b0d4b2f02e048938e923aa6e619.camel@redhat.com>
Subject: Re: [PATCH v2 11/20] verification/rvgen: Allow spaces in and events
 strings
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Thu, 02 Oct 2025 13:17:06 +0200
In-Reply-To: <87v7kxr2fr.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-12-gmonaco@redhat.com> <87v7kxr2fr.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yL734IPvidvZm_9TRAs9gjzfQh-6O7iTVpDxqziwQQw_1759403829
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-10-02 at 13:03 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
>=20
> > Currently the automata parser assumes event strings don't have any
> > space, this stands true for event names, but can be a wrong assumption
> > if we want to store other information in the event strings (e.g.
> > constraints for hybrid automata).
> >=20
> > Adapt the parser logic to allow spaces in the event strings.
>=20
> I probably misunderstand something, but isn't the description
> misleading? After reading this description, I expect the patch to ignore
> spaces or something similar. But from my understanding, the script only
> allowed a single event, and this patch allows conditions as well.

The script allows multiple events, all separated by \n, strictly speaking t=
here
is nothing saying spaces are not allowed in event names, but the parser bre=
aks
if there's any space.

This patch allows spaces in event names, conditions (separated by a ; ) are=
 not
supported yet.

> Shouldn't this be squashed to the next patch?

I kept it separated to avoid pushing too many changes in the next one, whic=
h
mostly adds new functionality (and lines) instead of changing the current o=
nes.

Apparently that didn't make it any clearer, and there isn't really any use =
case
needing event names with spaces, so if it looks cleaner to you I can just s=
quash
it.

Thanks,
Gabriele

