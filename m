Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2463FD12A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465897; cv=pass; b=QG00IURnXyKl9A+ZaftIdG1DQehseZAQyZA/SykaVeHCwdHQkybOA2ADxbLpRA2GLVhcxQ+emWTMH3Nv97Cr19ZOzk1rrXzvxPkcylmAAPHNSYUjc6nHDyqGJ0n8XQ/AZ9kxSxBze/VvhuiBj1LAswx5xVHVlq4axrTRYDnXMIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465897; c=relaxed/simple;
	bh=U86rsPMfdy4GrZhsYcX9lKmL5j9MJjGFwK5FrS55UBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFFy/+WG9lldPuheuTs7a7/qb8N1KhTHnXuYtX1L0KeF01VZ3rxGJiZRf3Dt8/9ml9JyYGP9lp7u583OF3WEq8/lVqWnPyC6gFEugjnyw4mYl0S7AS2bQFSRTHl6ROdGUJnsdIMEsOjIPEmgmWXqLqGDWlkBFzxfU4zAH3hQSd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHO6Kuo8; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHO6Kuo8"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-389e268a9b4so70290531fa.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 07:38:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772465895; cv=none;
        d=google.com; s=arc-20240605;
        b=SQJ2NyjJItSXyXDvXR7IvxJ/qg2nGvqUNTbL514xOvIpq9CT1+3X5HTLa/c0N/cKc8
         YW0TH48zDgTxd3sgGrie2VyzZC553L3Iprd7diHGfuBfx6IW3e7O/ns8rnVG0+qb8+u0
         4IJFrAkkkfP0zHTR/LReFi6fSyDCKAW9nnxQnCwPJNxI6R+MiFORy2xjdEvsE86cgguP
         KtRznBW+/6dZt+TM+zHfE6VKrHWrmIPmQVNejSaTUMK2oUNOqCpAobauOc1PrhI2/ejE
         +arg5pfKUZSRtSTmeRKbQV+TCRdiPZz9b/KM7kheyBi42SV6hx+YO5iCqpZpXcX1ZMxz
         35vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dYG94TPbWCbZG8/V8D/k4AWAWl2gqqa5tdO0TdpBNkk=;
        fh=tkvA3jiAtwPnioeF38elG9BGx5ITO9OD7W7eSU+cPDM=;
        b=iMalepW6YS/jdxEM3NVKCP7MYgbvVRzxXka8b14tj3oNWWnR5H2EuZhDEXNBXc6s23
         e7QKZaa4UVTHWne9wKM1JW5NGUQd8DZDg7gsdHj8Q2Q1I6OFNlvebJqDfY0DDf8wAqPR
         bFD75JsPbopMbpwNUo8kg1BYaFz9AhsHdRMCzpnxFbeMmL4MOf4o2AXwmiig/attwcAm
         w9EN85+cvxiSMFBOWEN9nsYuKJQ08ikhSfybz3pCxpRdUxTlbqrp7iQSSpt+oPE5iMxY
         +/UmT97RaaMLaYGdK8p7TTT1RUTTmt92K8KM+VYq/OyWUMsJ8B/RWGvU4nDj88IH7Eie
         3Gdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772465895; x=1773070695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYG94TPbWCbZG8/V8D/k4AWAWl2gqqa5tdO0TdpBNkk=;
        b=CHO6Kuo8549glFK4Q8YboLs6LgqdXYpj0TZD/pbKufuAXfPce9G11BV1a+0aJucw6f
         XzVQo0IljXE9NOlOnYs0V7pJbV3Rr1MLDsGTFQ5hJ56378OxKndjVOfKFXT6ywexaKYj
         GKmKH/W7zFH23M20uNZZNn8aVhH7/i+76UWGkrXKxdDyZR54+ZSz7xcH+f3NnN5dCtzv
         X1OD5UFg70etBpCg5hLp+9ZCJYj+6b3unXAxQWjO6Jh+nusmYKIabW+qFVZVautTBTbH
         ovqx1dUbWEpooLnPg8KI3A/VkEMcw+Yjdyz7m1sGn9QBA3qDJp5Kv7JggzJziOPzpOhN
         8KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465895; x=1773070695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYG94TPbWCbZG8/V8D/k4AWAWl2gqqa5tdO0TdpBNkk=;
        b=RmxQFoDFxGOAFBIdXR2fmEligpNOntqftU5YOz/Mwv3lcXUZ9cKD5CaKq8a8ByCkQ4
         GR0qKobGHT+NXZ7XFENVyA5Txzd6tf9/KjmOJjtAChmPrGCZupmO8buKLwTspUhTbad8
         flf1iScpbJUu8JyuAtApOzqB8rHPEJyCJ6O6TOjAwBTfJHNbFD/05MSKSZ8zqipyadug
         MSuLUWqohJGQOB2la1Gp8KqeTCT8fhfGn0D7DPeO689/U3YtzsGkkhVwi8XdbfhD3/tq
         vUtquX8i13axmUYwxQbAym2hvlzXzNwUQu4SoymwKsiNmdz8coyYX4dYIR9NYe+pWNdr
         q9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXb0D2oAenp5A0m8vXlZ3V2wF7pmyotBtdeL8WHDW432sMUyfgPxDCxPf4+V1aS+ZJqu0wKHXWLMKellYmyIjcgwNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZJu6xFmVVEQu1QDK5yfs2kAg28IXTb3IfKYaRRBnhj4p5Qme
	uDhTBAtpkLI8oVM3UGpPqCb6WqK8lXdrmlI8WzjxiL9iRUvnd0trxnb0ojE2BYDtaf6eWNtdmhU
	p7ESYAJmOAQEcX1XbKL2H/6HLPI73t6hODjUI348=
X-Gm-Gg: ATEYQzzCJTcNQVoww9YUDHMHT9hI78ogPb1tr9wKmWyent9nRqRt/Dxi97t1RXDVxos
	uf9ElF+ylvqHBJM2Ro5GoX+xKHasFILaUte4ePHVhsl/w0W0r/acYXH8vn0p/QU1o4u4bw23BtT
	thr1RFdbzmpfeRKF5Ez8OjmiJ2vXjSjxy9cfzXC9vekPsS3BcH1eIFU0Sa5MyJXnHQoz3YHDi4T
	HV1TUPA6OPslAFHNxDCdSauk9WKFc4+T+fttWNgazutngWmAyIKjcypZYAicORdasQcpCZoArl2
	GNFm5C6+hMV9+P4uRWKFruYuu3SG2L6rvsMre/JF
X-Received: by 2002:a05:651c:43d7:20b0:387:df8:9373 with SMTP id
 38308e7fff4ca-389ff1197b7mr60947671fa.9.1772465894306; Mon, 02 Mar 2026
 07:38:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXtAv3u1hgLkBEbEgR3=r_iz3=KrnHB8B-=tg8Q3CEOWAPFiA@mail.gmail.com>
 <aaWonCzCLayQDXOT@cmpxchg.org>
In-Reply-To: <aaWonCzCLayQDXOT@cmpxchg.org>
From: Andre Ramos <acastroramos1987@gmail.com>
Date: Mon, 2 Mar 2026 12:38:03 -0300
X-Gm-Features: AaiRm50gg3Y5F9SqTPBhJaPRyGUa-m39VJsleid6bB5cl7M80SOXalQD6eP8Sbw
Message-ID: <CALXtAv1=p2h7fH21SKgVktTSrafB654hL_hgUW2WNbROSr0wzg@mail.gmail.com>
Subject: Re: [PATCH] mm: add Adaptive Memory Pressure Signaling (AMPRESS)
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you all for the review.

  David, Lorenzo =E2=80=94 understood on all counts: RFC tag, patch series,
  and the maintainer entry. Noted for future submissions.

  Johannes =E2=80=94 your pointer to PSI is appreciated. Given that it alre=
ady
  covers this use case more correctly and without the reclaim path
  overhead, I'll look into that direction instead.

  Andr=C3=A9
