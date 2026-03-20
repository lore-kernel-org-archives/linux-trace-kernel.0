Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C527FB05
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Mar 2026 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773974492; cv=none; b=ByrNm2ynV9O5wuNtpPjdoaz8gzQVx08LSyHTilAlG+Yhr11NMvMZgdn601BXqwbVmiXIimWWLbHBOvMw9izGnvs3UmCjuj5Pd9OGzsRC2FY1PEafVLIeKxz0a459fdUUaqxxM9xS1n8IwRoce2rhMPpLm+tu3cHQhASd7cky45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773974492; c=relaxed/simple;
	bh=gx39cXvKf6XMjyeYPfkYwFWnZEfzQCZYY5Fl2/L3sR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFFNlAcf6pzQg4VEw+0xSQNkXL1r41E1Op36d1nUvcvUDlvpT2u3j/Dy8vfv5dqV7LBrwV8zjJQb6QmcozxgNygmYzMVIZfvRbOwcEwi9ePIwtkf/wAnG8qFtfctlC7bYEx8noF9/kuP4JQNQcxX2zukxLGPU0FFjl6BfEZsyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0pXYUYZ; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0pXYUYZ"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so780605e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Mar 2026 19:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773974490; x=1774579290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA380pCFY/heFJYh+oChUrDKsjPjqMAgTd7ssSWj/lA=;
        b=B0pXYUYZHn2lpMNyMxrr98KJgzTLZ1lrdrurpNXLcDpA61uOScy5TbfFlwAq7cEmtG
         3NrASE/i1i2VATLZN5Tw/aAcnVUxwVtasg3PNKHGgllDacoEwiSMGabsypcMjbuIAFoM
         vXw4WB+7TFjMZZ9JAwvvNrNO7Lnq/Vo/YSijzoNfg2zwm6RDVrWbLs0w7kyGy02G2wUl
         vfH2f1yiEYlTVyuXxeuaYd5o8hJ325auK3PlqZfZvKb+XeL20UuT85OX0O4S/ypAi+Uq
         ybJA0+dOzYw+Cd5hCWwZ0VEo0dPF/6EJL0DxeX1PXQ1BCWCzWgFvlBm3tTRVcT55eZ7f
         DsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773974490; x=1774579290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hA380pCFY/heFJYh+oChUrDKsjPjqMAgTd7ssSWj/lA=;
        b=J9NU+jGmNTAQlJRf0AHMJXeLRNUqei3ezQF+UHbnBQjF9wQweojC5DFrRczdAP1JnJ
         sWYTCZXEGFX6OgJnjhDmirBynd0WIe37gqAy4X+GzWTdFvcFl+6j4vblzj2uXI6hdejc
         MO4LXqwn1zmXm972JqiMrA4tVmXU59fLiUdhRcvSBgoz/QeX7JrdgW0WLdObovPX/IyU
         DMmqdgOA654b8GkhlaDcJiiDKSIyA8EpeuG2SF1s2jGihNiPGA/rjiZhCkMhZjXFOQhF
         vIk6PVQhk3PzlIBTFN6KYkVLM3YrbaujBAZqM58L7KttI8SYM9tplApu/w37QuL8f4HJ
         5MJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/8XzLGQQ4G9IZGe37eR/ysk0E0ge+ij6zSKbUmpSsz32CJEJrqRmbovdPHKtiQkBkjVvv/aLIU0QkbHVL5vqiQBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7nlkSmeMnD9UQaDFtaY4ckNNCc5F0Qa8X0Cqavz1sWTwqe8O7
	DnjQV8ZxgrY7ZNDUs5xANrZdZDxaPv7fv3RbruyKilxig+RgVC+DwGx2
X-Gm-Gg: ATEYQzytUB25Prs0cIYUVSYhubXRMSNDkbsrSZ3gj82O+B+1DDVpONTcADlK6toUerx
	3rWWi5Scg8b8dPS6BSKd/4Rd0E3XPU4GZ7RAZueqfmNK32ptn56LE/c0XfdmslvDEYU0yGZ922U
	rxeRXZeXik5afhqGyF8ZUbXCwnmJgCS5ZZs3Z3LdUMMcXQm0PetlWq18E5dejGSCdSNgAohD0Yg
	uduBzw4ZOtA+GlaXsymjoYCrsUbcY4bl5cgtqpTk9bBDy2hNZrvrnSHh3CrIPIhRuwaiETWHVie
	cw3FdSMzTuHO4kszd5oKlqj3K2zWbzvmBXGo5c9sESDNfDLJimFfxM4hBLYqFMip6VKmzTyHXNV
	dtQ48Wcgi9sAjIc4X0DlOJ95hF4JBdv2D7CmzR8O/vhFffBO/nMNNk9v3oij55aKWaGy2+7m+ni
	43IWmIfIVXAdA0nLINUvD4kDfnLpABWPH3//XNiCbnFk/GPmKLsA==
X-Received: by 2002:a05:600c:c111:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-486febbc310mr13756255e9.2.1773974489489;
        Thu, 19 Mar 2026 19:41:29 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm2416039f8f.4.2026.03.19.19.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 19:41:28 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+ca51b6e7e751edd6bbfd@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run4 (2)
Date: Fri, 20 Mar 2026 10:41:16 +0800
Message-Id: <20260320024116.3421185-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69bc31f8.050a0220.18f14c.0051.GAE@google.com>
References: <69bc31f8.050a0220.18f14c.0051.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a fix patch [1] for this issue, and it is the same as syz-AI's
analysis.
 [1] https://lore.kernel.org/all/20260304092345.233522-1-wangqing7171@gmail.com/T/

Some similar issues which have syz reproducer:
  https://syzkaller.appspot.com/bug?extid=9ea7c90be2b24e189592
  https://syzkaller.appspot.com/bug?extid=b4c5ad098c821bf8d8bc

Welcome to review and comment this patch.
--
Qing
