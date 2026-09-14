Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94838479892
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392913; cv=none; b=ohoDPbTETFmFSmj7uI19haoI/2GLj1yes42Ud1/PKm8NvdUJ+4z+GKjKzAVRXeT8lqHmr6j7eKQmXR7Vx1ZAA/2w/kx+3tlQfjngWByAY6a1NHH1oJucUY7tggv2xAXFRnj1DlDnu+ai82hDAPGQ8l5jGW3V52LhTdcx9E1xBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392913; c=relaxed/simple;
	bh=As8oy9p2U/FOh1PZBgbp0wxjF5Af6Hqf36eaXKu2y40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2c9g0889Mbrtx/suT7BUzFqshIxypTuS4WoDBqpRaVCX5eaJTtiwbOEK2RXfqlBwgIojUJNfiSBnYA32OgFYoxm942xG7BijuuqVPa08Tq9Xqq5CRH9K5LcR6SsZGQFZXx8eHgJekb8B0ZtgSlQUDtUaxN+qcEJ7YQHnfJErPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAUSGS/9; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAUSGS/9"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so275812266b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392909; x=1789997709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zyEGDSNNvqXj8TlYB5ZEQxBeM/jt7zrTDK+jYodDq/Y=;
        b=nAUSGS/9yHiei3VffWSNqXD8eipwnkvS//6OlDiywilpmu7TZau6XMLsaZ66ZPetOK
         vi2OngSzZ2IPxbPXm4K/C/2kx+PnPO3YChcACfQvqM594DQte6BEZmziHZL/eigW/7wG
         BxzDZafUd9h8JPhPb1Gx2KzPD5/xS+5UKZQv3EnZpK4WOlUjFQqe6DtkI2AYkBSRqCrU
         9TaBhaj8L5SgNRBfWGBqpdw8EcLa6jSqfThAXX+g2TpjW+uUciD7xF4tpHPu7OhM9S1/
         mNLMlk0ju808u+BNjhPPVc78p+5KbLb7zJBBE/Z7IIO+wvsClajNboLXjELwB0yJg1+T
         WNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392909; x=1789997709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zyEGDSNNvqXj8TlYB5ZEQxBeM/jt7zrTDK+jYodDq/Y=;
        b=d+sCzhZbzh8mudAxWuZtEeDtdn4/zJNrGLWfCiUNFENX4ljN0dLMfKp9VPy8/fqCHT
         Opmrf4LWuedknA3WtJRcneU4x/j7zMH3lNynMFH/tpWnChkf5xEAEe5aJoaN1dhOx5g6
         9H6i5XM22KW9zv54w6UQV/Mue2HXhWe10CyeBurTs0CsDZUdk1rMbnC9BE9bnu0uz9qQ
         EhHun/QoshR86N5zISwjXinUF3EFp0biRFkyhgIG1fLi7/GUPTbb+qt/DgJ86SF/BaU/
         sm+rcGjlkpR5fspg6X2UJ1r1KvHR874kNbk6mS7bRtdEiRANIRlfoG0Jkso3UaQnSzKe
         wFSg==
X-Forwarded-Encrypted: i=1; AKwUvBx1eR4rTQZjBymuREyunMZOQAkM1T0hrh/sUPJxnmkHi8HJh1ZL4++u4V+aJSr6h6p5pT8K/cXxTJq2IJyIeUq8D3c=@vger.kernel.org
X-Gm-Message-State: AFuF++kFaUtmZB5kLTlf3dyX71cejTJ23RcOmRWs0sJaWqo8Kf1Gjg/X
	ZKl2ltccYUE+atQqtmxPV+1iriPjvR2STuw5AumLD2HqozAgms2K671l
X-Gm-Gg: AYBFou0jUKW+GqjrtGIr78HeFBzRNEBEF26qhxaTpVXoGqIBjNqpSUm7CtaUxSfp6Ka
	ezSEZjxseV386UOBmLuOf4nUIYgP/z3Sq/VC06po23FXKadzYw/syO966MA/+jZPXLJDqqtNSNV
	94jAbf3zYzohIvQFTHZcyUZyN0QzbtZU3ra5e50m2mvDWQegIa6U/gE+tiAAcN33ySCRZCZLozG
	GKoVOwbG60i8wpzFuxwEjuciaGve4b9c4UUdZ7Ct59+oVauQ8mRlk066io6FuVT6rL92gIL3C+v
	TS1OPkweKn7H/RHPXNfDwyqA/VCO4PVvedHNaJqCoULuFoS3Q01J9oUhgcsy9rnWhIhtm99uAu6
	Bz3eyM4xHK7Qq/fTeFSPC3TMP1QP2nhqehdim1ixY54NDuGJFFsEkHvAfc9UHw4d5UzxoQBUwpp
	7wpx2sE6n3kE20LGIfwT8NuYMxeBs0xdGk4ROnhc7B3L0t2hbuODWXH1M2Qtg7D5eswMGOJVrCK
	BBqRigXRrUafjIrxc5KphuxUP4VORyxfzTx26aWILgvjPkBuf02hYpSBm8=
X-Received: by 2002:a17:906:c103:b0:c29:6136:9f66 with SMTP id a640c23a62f3a-c29b85fb069mr157357666b.14.1789392909068;
        Mon, 14 Sep 2026 06:35:09 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966159c07sm441454566b.63.2026.09.14.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:35:08 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2 0/2] tracing: Fix buffer_meta open paths
Date: Mon, 14 Sep 2026 14:35:03 +0100
Message-ID: <20260914133506.4865-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for per_cpu/cpuN/buffer_meta open. The first drops the
trace_array reference under trace_types_lock on the error path. The
second fails the open for CPUs that never came online, which would
otherwise dereference a NULL cpu_buffer on read. With the second patch,
that error path becomes reachable in practice.

Changes since v1:
- Add patch 2 for the NULL dereference Sashiko reported on v1.

v1: https://lore.kernel.org/all/20260913133829.15307-1-devnexen@gmail.com/

David Carlier (2):
  tracing: Take trace_types_lock when dropping the buffer_meta reference
  ring-buffer: Do not show buffer_meta for CPUs without a buffer

 kernel/trace/ring_buffer.c | 3 +++
 kernel/trace/trace.c       | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.55.0

