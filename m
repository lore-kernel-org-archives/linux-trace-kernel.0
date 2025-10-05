Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860B34BA35
	for <linux-trace-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759673810; cv=none; b=Zk5MAdjUw0IdSuXQPX5pkKkXIOStxxEWlroes2M+mdBgbzEO7QPgkXHHRmTa/RhswidUXshZfvfYvtskBBdLKPMN4lp5B/2Hqhqif1fAo+5Bn1edTMmFva6OSQ4a3Pd+but66Rp4tIkUcOo5EHwm86XvssBYPtAeRYzzI0Mqgic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759673810; c=relaxed/simple;
	bh=OdOPdNizzhcMK+2HVt/uNh54Txev+s4Tbp4dOVobb0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EXu3WvtjM/Wlap/7+rKc/nTTp6WMSceVJ67UB1rOcgQxrAygnqhVr47QmhtA8d/jtDIZiu2/DVE7vB8WQpmnOwy4MExcO5ODcKD2mEGEZUDKFijQ7OtEDQFDXKt8mfMGXnf+1XkTkf1FaZU8K6TrktI9yMrJHijIRmQcMFCxP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=h5uEgpl2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="h5uEgpl2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77e6495c999so3988885b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Oct 2025 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1759673808; x=1760278608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdOPdNizzhcMK+2HVt/uNh54Txev+s4Tbp4dOVobb0A=;
        b=h5uEgpl2yB4EHAKqjpixIm2xnEhctMF8HcMgDgugIwmteZjkHUELOyaFQdEk9oOWmk
         iYvvVceFJEYmq3Z1FIeq03IrmucVrfhA/LfKXkzQymtHkeHKcT2A2ymuZeA8HmM81rAe
         bTvFJq6aHk3IjVhJiDscphHyNv/d+tE1YTgsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759673808; x=1760278608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdOPdNizzhcMK+2HVt/uNh54Txev+s4Tbp4dOVobb0A=;
        b=OCH05VAyZBvyeR5vdbjrXCS9cF0Z9DjpOqADgFr6OIkB8h8WvhB8Ui8pwAOErgDpHD
         86Ezobp3OXhNBFNW6ZcY8T7WOYKgfRXKOTdj19g0CXpQvZK9H6J6oTzs+4/3cuc1IpPG
         mv1IeyFIV0IVEm8KB/2y0hqFfZ7hh8ci+Q3NGXqFYoZBpc5qz9lhP/IWjVq8x1lwiHOC
         pRsmLN0C0I/VqG/mLjXZ3RhmFhVOPq4gPsjz3Alap37/FT6I78VfKR9/Ed8fzkTXovIM
         +bjrTiUFZf1r3Qv8x0F6rduYliezox6Ne5haLJG6aLH7LdMmkRANNDKO3qpuMoH1Ze8r
         qvDA==
X-Forwarded-Encrypted: i=1; AJvYcCXqP57fN6VJoYW0Szb/Ti/B+1Bm7NLGhwWedz9s8IDR8EISYduJL3hIJmvCItrTo7boatGDyG/qoOlt+4pmIqqq6Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0Lj4mtsTbuYb3LtoSX1e5yDuH7KJNCp+H8JqLFbgU9WtZnDs
	q5lquhQ96NdeYCcW/y91MKXJx6EeGKuKv+gAGUclqF2Ialam2nHEpEVNrpjYDMKGEPI=
X-Gm-Gg: ASbGncsOe5r/KhhUHp7zq3HPQ50VDKMG6g8FnspL58No+4UpawopRba3hnO2SzVN0Hw
	Nb6472jcNXVjGA9Fz4bZDMTFRGCvCVxZdL8hCleoPtp3lxxywZlL1Pae1lrwk1osX8T8T/X8HeM
	eHGOWemrRH9GHYuHH0ESZjGp/AStqP63fPtrl24AReRhx+Y01Yqe+SssB+zNALALeFjjneWn4Vl
	C318g5P8Rcs7rUqGXqcx/U+lgBLvZEcCaCergMoqayhNCr9MYGVSksilvlLYgLXiSe/gASntIoT
	EYN3UdAYwEINAqUL2wY8Z/iuq5CZ5q5+fH23pb+Zs9OWUZufXXu00MAuCoDLhjTMSsRnDn7ZoQw
	oeTW4DldpVgT2h72o8qP+J7BvT+LzLWkqGFDAu6JHeg+V+m//TF8mi+j91Rr4D2B2U5SdpUDIRW
	heCmjuxqdpCn34/enq7jYo1+tn0lE=
X-Google-Smtp-Source: AGHT+IFq1Q0QVyU5LNJ+52F14B8VFbcLSZv/AjIFhMVdlEtDnkad1OyMGdntVBJJaXnwHFLlEMTzYA==
X-Received: by 2002:a05:6a00:4fd3:b0:781:8680:3175 with SMTP id d2e1a72fcca58-78c98cad8dbmr10216182b3a.21.1759673807907;
        Sun, 05 Oct 2025 07:16:47 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d016:a866:8cc0:feb5:15ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b81760e58sm8301295b3a.24.2025.10.05.07.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 07:16:47 -0700 (PDT)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com
Subject: 
Date: Sun,  5 Oct 2025 19:46:35 +0530
Message-Id: <20251005141636.12405-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <68dafe35.a00a0220.102ee.003f.GAE@google.com>
References: <68dafe35.a00a0220.102ee.003f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test on: linux-next


