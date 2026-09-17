Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D13AA9E2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616035; cv=none; b=hjDWWotb/ui7vMg7uZJXEJb9gr6JW2aNa8COWmw4elJ7iPpcYfICVDFV0Z2ODxZ6evJH3J320zWdfCoiqdbOusoil0299so/XkzRSv8jPeKViE/sqU+K9MAweioIpNp5CjJ+xE/txRklr0+8/bk7fSh8oWDlQmm5Ovk6iPQMVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616035; c=relaxed/simple;
	bh=xiYVn57pn0XMpas+wlR8SmSSTnMiv5JdI/rPUiCUEF8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FRrPMlxmiBtUZNTW1wzMydgTuuPM1t1KSun0E7Mm6sJqcQ3haPEAAlPefLfV4aJN03nOXV39ePTduljax1XB0MVv5nicrvQynXm1DKm8Mnw/Csfnsp+1ARS2Xqb/R9sy5G3oc5UsID5qc1J9vTtizr73zBGq+ov0+r5jKie8b7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQJJ9sWv; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQJJ9sWv"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f05ffdso2920565ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 20:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789616024; x=1790220824; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xiYVn57pn0XMpas+wlR8SmSSTnMiv5JdI/rPUiCUEF8=;
        b=SQJJ9sWv8kbqLvyicyIH8dA079Hpdf7sAIGAgsa3gu8az9fmonDf2Wj4CjjeHdDevw
         GG5DXGNWmjOJystNj0aFKHITBrJ4HGEIRiBZgncCCyfssABBwoE9OjohnJi2mP0LKUKr
         Egf2WxTdjAwi163gzObk0VTgGiKgJXLsa0bK4+Lh6hcZYw7+ytQCHpC038wYeFxjgBoG
         wKzMSXHLic/tTqq0X7SnDw6UlRecSPNdDGwgx0Onfiw9m5xIbuhXLyYroSSik1DguWnx
         ZmNMq1sTLuEOvpEHBv1THhC4lQBcket6CLDcZAxkol4Czdoh8q91xdXW77tVLbQSYnoD
         GVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789616024; x=1790220824;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xiYVn57pn0XMpas+wlR8SmSSTnMiv5JdI/rPUiCUEF8=;
        b=D7iVFgLzmIC+sArDNA2l9mF5JNhrL/HJSLr557usF7pMyOtsRQXMF133C166tu6fEV
         cagBy7TbL2zeXSxelfyiE2+zGC7D4AYgN21GF/OQ9cjBwOctQ//zvreDNEIsD3wZjL40
         T5fSbRFNzMY0mlWzqfy/ymmhqErJHS7yu+EfaUiY2lpgNVGf6pocr2UYfWAfbXTEvutG
         O4JP5qbDlKaNfYj1PEMIOqfPPrHpDryHvU7AGZCqKYSx5E6Hj0vuo6zqKUTmSY1OMSHD
         B/fgZgPyY/EyFu53ZBLvDq4YpqJfLjc/XdGXz9+Z7Ob92srxpJpV252kid0Q4xDGrHEU
         IscA==
X-Forwarded-Encrypted: i=1; AKwUvByE4n2BeriFniEq6pkp/eXPahTEwhM6ItLfcV/ZQcAW7w+CKbwN0qN4PeQPe+1izenBQC6LBQD9mkknWnyvu75zTuM=@vger.kernel.org
X-Gm-Message-State: AFuF++l/37CuY9iDrGIHTCJddD0KRGuWEsHExbzx7gF4VTnlAWEQxW1J
	q6ikVoMMqU3cx6elPol00PXbcsIilMi9GbkuysTk+4m6Bk8Jb3draXxO
X-Gm-Gg: AYBFou35gHbYQeLJbMseuGBR0ybUdfISBma4BnP6OaI77xZVRCqfJxlN7yGugc/d9xU
	msyQjXcoY9Pa9Xpu2/QSVhtb/OV/Dqk6Wabivcw61EIBq2MoVEZebUubUA1ZNjqr+TZ/nj3pvge
	dZZxeYPSQN/sp7iHyAEb/XM2/d6XV6pAExP2rMZVIyR9iB6eV3ZQg56HI2Hu2ND+2M3SjtdCUoD
	0EXgVvsBRzoHyuz4fsimO67lcSptdDCDPE/sep4XWKkgvkKnHy7ir5thLbqS2Mb4I+me5FMmlYA
	ByKjOOzh0dRJ5H9K1VDzWdvO/HoYuuQP6qECP7UPO+V9ecJpTLvhtGtZHtZkTWih0LAOH7K7YCG
	OLssD9feiZDJ1v1S2nZkoUqfBw3Odup6Lw7kU3P3+17q1OLfZJE5dLZ9VBxzOSUWzIY5l9bbj3E
	yrYrASP4jzuTWL0T1wGHGx5uiGiVL9zXmpeGsjaJFrP+eMzjonhKmyJJavb+m9yu0vYqNvOXZtF
	6GvwzCKajwHxJWK7BMeIKVkoosED8wTVOuug9WxCFghTyJsOjfavXEf0mJezSmFDtufkn+ueB31
	6kyY
X-Received: by 2002:a17:902:d547:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2dd8dd0b15amr107107475ad.4.1789616024059;
        Wed, 16 Sep 2026 20:33:44 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89eb5826sm19687585ad.30.2026.09.16.20.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 20:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 03:33:42 +0000
Message-Id: <DLH9XN5U55Z6.32MF649M30C6P@gmail.com>
Cc: "Nam Cao" <namcao@linutronix.de>, "LKML" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Wen Yang" <wen.yang@linux.dev>, "Tobias Schaffner"
 <tobias.schaffner@siemens.com>, "Viktor Malik" <vmalik@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, "Steven Rostedt"
 <rostedt@goodmis.org>
X-Mailer: aerc 0.17.0
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
 <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home>
 <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
 <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
 <20260904123108.1fa1d815@gandalf.local.home>
 <20260904132421.111c0279@gandalf.local.home>
 <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com>
 <20260904194620.0c7a8363@gandalf.local.home>
 <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com>
 <20260904201741.2986efca@gandalf.local.home>
 <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
 <228FE969-EBFF-4B60-B0E7-C1E4FD82FB8B@redhat.com>
 <DLDSQDSVXFHF.18X2UQUL5Y42D@gmail.com>
 <1f8caa71b79e70f554245bccaa29b66268452dbe.camel@redhat.com>
In-Reply-To: <1f8caa71b79e70f554245bccaa29b66268452dbe.camel@redhat.com>

On Tue Sep 15, 2026 at 7:15 AM UTC, Gabriele Monaco wrote:
>
> Essentially sharing the API simplified how the userspace component handle=
s some
> things and allowed to share reactors.

It's surely tempting to reuse userspace, but unlike kernel the user
space is much easier to change, so let's not add kernel struct-ops,
since they're not necessary to achieve the goal.

