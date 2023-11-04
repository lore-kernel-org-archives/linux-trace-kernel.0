Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC879F5
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Nov 2023 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MtMgam8o"
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136981BC
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:16:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc329ce84cso25410925ad.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699089387; x=1699694187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLNQXwvsmuV3fVIiwVg4eaHyhonWOyCC10q8MYVA8E8=;
        b=MtMgam8o+3y23wLubmu2Met3dmmSp5k1T27AY9yRvH6jq1d3c8n4pwEixLB5n8dvUb
         8RIvBiEopV8pdyatqcjHSDOzDEY4LleRDBBs3j4aG3rz3/PJNlIJ3QX9twdwSEs6tjpL
         9JAC7UeVje7kw+KwhWC+E0aeg+I+uLajEH3XZgvOHRJMZVQm69oUdDkuxj07qNRDgcdU
         Gda7zCT9dbtxOQNj5suysj4Cr6n17vAY3uR7SpFTotFjFgLWD9UEM+aWIwm7wP94M/0j
         tRhbVQw7bmzy1GtL76RMW8tcAFvMJ9InMVbRX9C7TgF+TIqPjM2HNRx1m0yzo9h+3yET
         JUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089387; x=1699694187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLNQXwvsmuV3fVIiwVg4eaHyhonWOyCC10q8MYVA8E8=;
        b=dHQlTIeS9CerclhaPY5/EGNVaqjtdvX7z6mQplrgq8VupS7o9Ok92bOnygcn0syJNo
         DPjVzmVjT56VaJ0C2eZ0NVqBCE/pKWkQeCs1L90NMF2xHpofLo496iefGwO2nWxrPK1V
         9e0W3GZqDsDZocECD1nJeLxMpNRK3XH67lJi2YwyyYnachwRc4C9SI4uUNi9+0CoZ2Gs
         5gf1dM9gCjpyktNlgakN/dtPBtEkuQV8hT8bEx9tCbynhyGvgCqKBnA6T9LkEo8G0vun
         bveOVK01lF+jIcvKoSiOyqcdbbeMnUj+Fw3MsdI1YrL93yRuQiLIU63n+YkfeCI1pn9Y
         Renw==
X-Gm-Message-State: AOJu0YxFd3qcFhj54It0mLaI2UBa6IhYmrYjO+mTjfH09FxApEFqDej+
	SeIVVzFKPI4yKs9en8NilEKhNg==
X-Google-Smtp-Source: AGHT+IHbBh3J3IRfyxckxOWlsKX9sadU7+kPzJ+J9v34NvpVCI+Bhzyj9lMKHXCD1k0j5ZNgkIMKOQ==
X-Received: by 2002:a17:902:f213:b0:1bc:6c8:cded with SMTP id m19-20020a170902f21300b001bc06c8cdedmr22211228plc.67.1699089387534;
        Sat, 04 Nov 2023 02:16:27 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001cc54202429sm2585127plh.288.2023.11.04.02.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:16:27 -0700 (PDT)
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
To: vgupta@kernel.org,
	bcain@quicinc.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	geert@linux-m68k.org,
	andi.shyti@linux.intel.com,
	mingo@kernel.org,
	palmer@rivosinc.com,
	andrzej.hajda@intel.com,
	arnd@arndb.de,
	peterz@infradead.orgm,
	mhiramat@kernel.org
Cc: linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mattwu@163.com,
	linux@roeck-us.ne,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v2 0/4] locking/atomic: arch_cmpxchg[64]_local undefined
Date: Sat,  4 Nov 2023 17:16:11 +0800
Message-Id: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implement arch_cmpxchg[64]_local for arc,
openrisc and hexagon.

For architectures that support native cmpxchg, we'd like to
implement arch_cmpxchg[64]_local with the native variants of
supported data size. If not, the generci_cmpxchg[64]_local
will be used.

wuqiang.matt (4):
  locking/atomic: arc: data size checking in arch_cmpxchg
  locking/atomic: arc: arch_cmpxchg[64]_local undefined
  locking/atomic: openrisc: arch_cmpxchg[64]_local undefined
  locking/atomic: hexagon: arch_cmpxchg[64]_local undefined

 arch/arc/include/asm/cmpxchg.h      | 40 ++++++++++++++++++----
 arch/hexagon/include/asm/cmpxchg.h  | 51 ++++++++++++++++++++++++++++-
 arch/openrisc/include/asm/cmpxchg.h |  6 ++++
 3 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.40.1

