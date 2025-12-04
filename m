Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A5933E35D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Dec 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764851948; cv=none; b=U5zDUhlqtKvxsh5Y+anB362rAOsdP0YuaHLs4U7glGf3ecjcJ0R9TNqd2kMiLLmUbUujX1C+ZBBGnFea07VRZzl5EqNdam16Mb4HXLYRcJR0CLX+ELF/oljSSqk15ybrQJfZtbcNf87gj+sAtEcCkbfqNKx+y6xEZ3jWofbSbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764851948; c=relaxed/simple;
	bh=ij8EL0R6UwB8ZDBVRFMV/z/L2JKiW7wDSAk4ODpKtjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3a5sFf+xelrHuKF6m5Tn4BWTgRN4omBawst/G62DPbE6oPyBoOz5lnfYm9w1NvOxcgWqh2KizyTiJH2FYlMlhUqwGJAfkApEgAcfqBjiI1zt5/l3CLh7+IUMm9Le+z/PF3z/bIcnb9pAZB1Bjl+sUu7vZHmhU6eiNvc5l5vzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsrNw45S; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsrNw45S"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-641e4744e59so793791d50.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Dec 2025 04:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764851946; x=1765456746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij8EL0R6UwB8ZDBVRFMV/z/L2JKiW7wDSAk4ODpKtjs=;
        b=HsrNw45Sw0qZhJpdlG/WgjH3nlhIEkm4EdpLNBUykie9ug5/9q1aG+EeLU1bc02nPm
         UUnXoFh601CHrbCpbStdpXOf05pyoBCWDH6ZTSXL8c2GpO7HhfpSfARkqY4JIp9biDRT
         vXJIOWL+UiwXR1H30L26SUeflgcBWUIrq7O7yyp4aATGa4XRwgnrgPDkqHs0ZpreNd5V
         lrjyjh5Etk6qNfx6sKk35SWiaTe3rMa12Is0CUBafm+EVb67M/LRBMFg+z17zwK1ucUk
         WXuTyC03Lvidk+CMPHud+2ANe7LjLj8rYyagl3TFQ+4wi5oQaMF/tDPKSm5EbweUzY9w
         BRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764851946; x=1765456746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ij8EL0R6UwB8ZDBVRFMV/z/L2JKiW7wDSAk4ODpKtjs=;
        b=cxuFv2QTgmHLCMuHdfHDrMsDHF/Fx8PHC1beDwQ25dqdQ4K/BUm6oKdH1M8LiXc0HG
         Z6vECtmmllGlQq+0nV08lLDDF1ZJ0FPcziscfyehkmymFTEr96QPAmhTFev5I8wiXuIU
         RiHyHdHyj4M6ommC8xz0dWeWSOjTgcaw4GZVpwg2XvkO+8AmmAAmqUsFIZ1gcyb9czvl
         mVLxmZUlng1Kz89BMsbgjksiHM6fyxA5XvbGGglCv1XMp1h2NVFeU6fUCbdKDe0PhuvA
         Rypp/DzQ/fBkKYmcmAoTlwgXL+cytl7B++DbBK25/bw4xv/j1taXncPngVT4WDnaO69y
         6T7A==
X-Forwarded-Encrypted: i=1; AJvYcCW2WqyChr4i9ge0AoacdaGZNWbA0WvCRHrFeZQBbL3aIsOTbZVt6x7qMnA6a3ukgllQKmmFo+zJu4KCOpGZ70sUXik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXESPR4MeIsLbq4aiS1CaXkVXNYrjy0ijdR3UzwGqweQ4i07f
	BKv7GUPb/owYnpcG4bShroYrrvAatkmw/PT4XDgUDaO9N+42DBVyUbmX
X-Gm-Gg: ASbGncvTZL4gHJu0gJbb+GmB9RP8d1Ve3o6GgV4X/9VtZeP5/AcfqB+e8D1E2RwkbAM
	nxe31NjIjTNZJUsOIVPIKp/e8dnJUocgEjO3O5h7ac1ho0QHcc8glYzkxQ3bKMro0K0WdapaygA
	pWivOycT432qX2gbMLaiKNQkyBTRBRSPf7oyac7NexrhP0jqiLJ7eFB7joQ0DkcntVOyAw+Yzu6
	V6ONiLkRuz3F9nokim9FHfdA13ju6Ct2qPPNeSMd7DWyUgSh6atNPJPpg4L4Chu4KVfvP8Yi6aX
	2p7hCyrdFaaG2wb2FaCUxtkQxwsFxag+6h6nFeLlel9hT8IF0GECx2VHfCeXpfYAj046sEY+cps
	IOwN634jDnnRAQmF3eBANGUu8mm1k8D9Q2D+Mx3OxWnBOw2CTafqMBFvz4PV+dikFFaeVscXJ5g
	o5e4Xt2ByPCUnRIGlXBNIXCPIREvusPkpld3XxMQa1xhUat7Y1sqY=
X-Google-Smtp-Source: AGHT+IGxKuUtlyaX8PN+PqMbMQ7N09I5gYeGDl8pe/k/jby/JuQK+UYr3WKkNen2o5yTwoJekvFxYg==
X-Received: by 2002:a05:690e:1908:b0:63f:b0ca:dc9e with SMTP id 956f58d0204a3-64436f6bea5mr4880835d50.10.1764851946376;
        Thu, 04 Dec 2025 04:39:06 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b78e892sm4766667b3.44.2025.12.04.04.39.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Dec 2025 04:39:06 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Thu,  4 Dec 2025 20:38:52 +0800
Message-ID: <20251204123853.1235-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251204074632.8562-3-electronlsr@gmail.com>
References: <20251204074632.8562-3-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I looked into the CI failure and it’s caused by the test assuming
/tmp is on tmpfs, which is not true in the CI environment, so
fallocate() fails there. Since /dev/shm is mounted as tmpfs on that
setup, would it be acceptable to change the test to use a file under
/dev/shm instead of /tmp?
