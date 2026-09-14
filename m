Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26205353ED9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366135; cv=none; b=fDoydBklrOTbW3tz52RAsMY6EGtbargGNi3vqXbWTgCOdsEjFiL88TUxYd1vcVWE94Iw5mnL4mAYAfg0NZmatGowYtIqv0bibLPvbbwAq3ugG3nK+1NsCkng23ikg9riS9oEH2Zy7Wt7p1VrVIQsEcaWTG1JOFfwNYB4tsIAjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366135; c=relaxed/simple;
	bh=4nrXIJVDXaUkwf+YC5VoiLxfZ+FG+C1MAP9IRBoZSks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkiVOPVBR7N6WY+iDf0Zy7Ro9QttB5Bsh8iRnNWFsrLWltcFNZHTYd+jCvwVV6lZMfWaqlAib+01RAX/ithkNd6lODxdTaJnpA0y5c8lxdNT8YER6F45ZYt7AMLphAtXFavvCkfhDrTgkPNu4WWf2xJzK7APlzscmJUxlnhSquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SngrwB5Q; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SngrwB5Q"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed1368so14695595ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789366133; x=1789970933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J7ZLRztZ4qGLXwZmjT6Sfe0hmRUFOBvBkpnxtaBdgb8=;
        b=SngrwB5QlFLlgcJVXTQdKyiSY1F7Cav+E1EcZAIfIKbc5Bi1Yr6hYFk7jcDmCz8Amr
         t8IZNXpRo15QIF7IaPJUwl6fRljWgImLGAAkkanK1YVLQamZkywFAv45m7WNccgO3Qbd
         Y0fF2+FyMTwrLzkoKMD/bUI7LfwiC0RbnyDNCKUt7oz98iFjU/SFKKsxsr2Y0z223eyX
         MO5X9SdKygY7opegjeZs2PObbSyi8pdffHkAoPJiSS1VsYa9MRWVHdAzCSnlgOvigYzK
         9rq2bXC2oZ+0gHNrHriKAq5g00+QEiKQTDkT4ttAa7PgSIU0nHzkHS+0mPVOGdGcRbPS
         Nv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789366133; x=1789970933;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7ZLRztZ4qGLXwZmjT6Sfe0hmRUFOBvBkpnxtaBdgb8=;
        b=iPRIDnBscKRiARmBoQVpcIp35xZ/Ud51shMYUNdgIxcqj9vsX18x9LaO48vniwkwuK
         TZGugc7p+XQRkEMIznfkj1FFUIUw85f8BxmCTsRsPKmJf6BoRIj+AHVJolL33Ht7If3z
         3BVBtqkqeQOIlN5oyeIHNB/1OPLMC3UP2lpAvxZ1+tvW+JbSUNon4ia3GbJNh6Rcto2I
         L4/lNqwxokp8iU2f5YI2r26QeDotH3ba1qFvWbenHcYnsjwEIrH9D1s4csjzgTqWiLSL
         WogkZMXNKg6iUlLOV/i2387wzO9reZfhHAcrzB+DLj7CT1OWje6s73c1xwCI6Jt8gfqX
         zewA==
X-Forwarded-Encrypted: i=1; AKwUvByZhudlK/mCOgskiU1yAtFbC2chWG0cBvzGPnT1/vV04FrIvIJAVN+LDB/wBh+qhjQIevkY1yQnEpfPN9yBGjo7ATg=@vger.kernel.org
X-Gm-Message-State: AFuF++kQfhl1lVINsLuerOVkteLTnlGfAsvqN6VagH083dYlfX5ifTd3
	QDiD6g8UVjqWRWKlRxkoRO3hQ3iNiUks29IrpICXtMK8KrrAN3JEe+KY
X-Gm-Gg: AYBFou3BjkKhJor1qu2GqM3qB9SmfOJ+gtPfZNWwj7rlfxw+ClSgsAv9ftzkjy1NBJP
	aLyMaSu+iZY+O89Tiwe946l26OatHyV66QBlhubW+k6tjSnG8IbOGTKkz3pODGGWZvFXEVBLT+q
	1d5Q9nghGQ4C/tddDql3BG9ILTLFEr6t6hsCVgdMb18HSsyHDzLVBLnT/dSCO+CtPMwPKQUQHI6
	hLsosjzMO6aQ4T0fNri+YoUITpdOijsayvzINBNHyzJWxdzevAe8DaBNzLsxpbJoMRmCzEgkeOu
	Jm7+ody3+Dp84WYyNVz/rw+8WiGq2e4y5D6FbKLdD6aPpeOWG6Uqg+wqlgDsDJutuAaTjOtjv05
	bq9weP3uoLETEP/v5tpcaI59fk63IVUyyGoWzxGCJRZmx2yX+M1E4X8GGJdyHQ5FsayxwhGDK7m
	eal6PHqRBE3A0HJT+DAXKwSo5sR/0ikcCzz0AL663DS6+irZtBBWSC7cA/h94e/H8/e/bil1PBO
	hao3QuHNqnIjImEC/kJtV4bIIATMzvQTWAJz34/
X-Received: by 2002:a17:90b:4b81:b0:398:cb56:e92 with SMTP id 98e67ed59e1d1-39debfb92b4mr2677452a91.11.1789366133460;
        Sun, 13 Sep 2026 23:08:53 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:a252:ce11:2d53:3638])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9959ac65sm18651790a91.16.2026.09.13.23.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 23:08:52 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: sashiko-bot@kernel.org
Cc: Pengfei Li <lipengfei28@xiaomi.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	kernel test robot <lkp@intel.com>,
	Bo Zhang <zhangbo56@xiaomi.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v7 05/10] trace: make the stackmap capacity settable on the kernel command line
Date: Mon, 14 Sep 2026 14:08:23 +0800
Message-Id: <20260914060824.4003131-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260912085841.48E7B1F00893@smtp.kernel.org>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com> <20260912083753.3426176-6-lipengfei28@xiaomi.com> <20260912085841.48E7B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

> Does passing this NULL pointer directly to kstrtoul() cause an immediate NULL
> pointer dereference and kernel panic, since kstrtoul() does not check for a
> NULL pointer before dereferencing it?

Yes. Booting with a bare "ftrace_stackmap.bits" panics. Will fix in v8:

	if (!str)
		return -EINVAL;

Thanks.

Pengfei
