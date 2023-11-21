Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M/kuTVt8"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2440F197
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:24:38 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso4714360b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700576677; x=1701181477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rO5gvBC9Yj9Gj9iwFUnYV9+FlJPZ82+bI2tRklE6bkQ=;
        b=M/kuTVt87qu0ZVJhQdMlOZPBlWefKfiRPkds/vddzN4iL6j32QUXBT68wPQRj6qWuy
         41gGIlSFf9+s0p8J+B+ZSNX+C+bBq66hdA9w71LyXK3/KFSMdXSI6FNZc35F3Vh9DvA7
         J8JOOS2+GQE6CQkS92puHF/BaXzAcqCIfZD8aRimjqnw6Zy/SUHykh4b6t1KtVYvnAw5
         3a6D3C7nh8z9qXxaWySLKMqqtFs+gQ1hVzdNnbDUL7odkMKyh65O03idtJrhAuW0uMHb
         +s+ndXS4XblI6bQ6g6e7XNxgSBKBa0gB4I+Tq2hd/TbVl2iaoDm0u0QM1EyQG/JW5lgC
         J5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576677; x=1701181477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rO5gvBC9Yj9Gj9iwFUnYV9+FlJPZ82+bI2tRklE6bkQ=;
        b=bz6NDXMxAeLyfEppQkrBEoDbpSz6vScrTX0vkb/ZJ5gnz3T3FaKwagFOq/twJF8tKI
         CWTNn/3QxEKSBM1bREHk97axZ8s7Dk6WcHMWA63NF/uIZrFc7uiGbwWgOR9OlpVEgPA7
         /wuhrTxLv4OGoea6A7chnyUW+Asunvs6kULTxYEDbrJMS3/dSO+L2DeTxB5Oe1C1WM6O
         0SjnFnb3C9yaitWj0yeP89a5D92mBj/xcmM6RvkMOZhtb/7H3tSIZqE+MwaUF5H+49XW
         LBXGkkHjauQWHOIvNu68NKtyWTWc3kuzUwUHc7LMfDOUBFm2DT7OCq5kxeDZXGqKwSLq
         AHOA==
X-Gm-Message-State: AOJu0YxXXjmIIw1Z/RT9ZbZmSqN4hNCRbfs0pM0U62UM0cCUFezhOXzn
	OkRbi+E3bJ50VUhDawqlTIy1kw==
X-Google-Smtp-Source: AGHT+IGZ0cj3qTxHGElldELTLLVk70f7H8QJHy0DgUxvrRtGVlmmImJxGtalz8fEj5aiHrvaElF8fg==
X-Received: by 2002:a05:6a20:1591:b0:18a:716d:4ac with SMTP id h17-20020a056a20159100b0018a716d04acmr6231274pzj.47.1700576677576;
        Tue, 21 Nov 2023 06:24:37 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b0068842ebfd10sm7923193pfj.160.2023.11.21.06.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:24:36 -0800 (PST)
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
To: ubizjak@gmail.com,
	mark.rutland@arm.com,
	vgupta@kernel.org,
	bcain@quicinc.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	geert@linux-m68k.org,
	andi.shyti@linux.intel.com,
	mingo@kernel.org,
	palmer@rivosinc.com,
	andrzej.hajda@intel.com,
	arnd@arndb.de,
	peterz@infradead.org,
	mhiramat@kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mattwu@163.com,
	linux@roeck-us.net,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v3 0/5] arch,locking/atomic: add arch_cmpxchg[64]_local
Date: Tue, 21 Nov 2023 22:23:42 +0800
Message-Id: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Archtectures arc, openrisc and hexagon haven't arch_cmpxchg_local()
defined, so the usecase of try_cmpxchg_local() in lib/objpool.c can
not pass kernel building by the kernel test robot.

Patch 1 improves the data size checking logic for arc; Patches 2/3/4
implement arch_cmpxchg[64]_local for arc/openrisc/hexagon. Patch 5
defines arch_cmpxchg_local as existing __cmpxchg_local rather the
generic variant.

wuqiang.matt (5):
  arch,locking/atomic: arc: arch_cmpxchg should check data size
  arch,locking/atomic: arc: add arch_cmpxchg[64]_local
  arch,locking/atomic: openrisc: add arch_cmpxchg[64]_local
  arch,locking/atomic: hexagon: add arch_cmpxchg[64]_local
  arch,locking/atomic: xtensa: define arch_cmpxchg_local as
    __cmpxchg_local

 arch/arc/include/asm/cmpxchg.h      | 40 ++++++++++++++++++----
 arch/hexagon/include/asm/cmpxchg.h  | 51 ++++++++++++++++++++++++++++-
 arch/openrisc/include/asm/cmpxchg.h |  6 ++++
 arch/xtensa/include/asm/cmpxchg.h   |  2 +-
 4 files changed, 91 insertions(+), 8 deletions(-)

-- 
2.40.1

