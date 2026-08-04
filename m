Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4901F46D08D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852244; cv=none; b=lca76Gnadl3D2xodgOxUkAmwgsL2kM795EA5d4aAcQLmbe+JcdC8g3aS1mscAy8dGhEDNUQbLYQ2WpnBOTIGg3kyiQmRcDmjWPxuE3XUytwazjWiEFTJe97uSgM2sD18Lw2sewOsn0dYgflr4A+67B3tF2Ix6XH+3aCeoNLlr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852244; c=relaxed/simple;
	bh=DCg18c08fS5yAw1n3O4p1XTPBktSW08PAzLu6waC2Mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oQ8xQXu8SD4AtLCezzp8nheIWHall74PgjDo0B2nNpUmq/B3V0/A5m3QZgecT7mgOVMXa93vHJS93QcUlrBMUT6ZxeXAFo3RtkrU6lNRw007j2vymr1BqxRGyJlR2o+7PXnno++skAU53mykJhPadeLeBX7Ri/fs61CMDRp2hBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDetKq2X; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDetKq2X"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954a93c565so19511605e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852241; x=1786457041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vW7zq9+GEo1dZSsriJr+LxVExvoRkhkfdWEBDccvs8M=;
        b=tDetKq2XV5F0VtUFHoIJJIAk1giWko1xQ1cF4PVG7LZ68FeCWYDrxDYNSviZsDZQJr
         kOsSVPTto2bpt5LltGqv2GbJf5Q9xHtl+M0wD/QFCfpH5s9CB1KbVH/PcApjbty4B1zQ
         ffDBa71rcP4TRnqf6vlxsRciaa+VigP6U79CMKK/RkmNOnogXcty7UwzBx5MY9LyRJct
         OaV8hjLbRpx18X1NIPFXPeUFfL7NSr44+ye4feB4jI0tziso5jHrLCVrJP3uEi+VbOIb
         uEPYsbWcIdTd6Rg+eaGVi/7rv6rx5zXZnPAPmgwde4eYKFuLzasKzaq+b9GQeQo6g3Bd
         tA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852241; x=1786457041;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vW7zq9+GEo1dZSsriJr+LxVExvoRkhkfdWEBDccvs8M=;
        b=Ve9Ti2YbXo2UwUN4X1s/34iMSLrW1ac5HeD/OPqGPre2K/7x/cPVlM5UHTzmbDsR1k
         KYuo4yzXjShit2ODghhq1+zwUJBXnqnPc8u1WWekXFHHjTEKXWYFeDRHIpKZEJpNVQ48
         Lk4PenxwnWo6XhCdv5rY+ijb4gSzjH+HCU9LDrw+ZCyEGew0+xTBq6fvugtRCcTsfDdS
         +0hx9QGOlIHLkXOvvnugPCc6R7U1GjITRvLrOdbVNgKtTq1oSy/k0lhRk+ay2watyx9F
         UDzpd2vbZlobFQ2JcHsnKl993POUv3fIv5ZcGw3RIdE+PJZwqpRkxpEBPhQXeeq8Nk/7
         HpOw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2LsOWJnvgmZ1DVkP5NZifgpOhzK4QHpgHdaHdHttudks5Rq74MSKPcCKixptF548zw8bUbJ4+gtdzF+dGJluFgL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysSb0ppgD/CU+K4CGVuYp/MUnKPPZ2FMG06j+FuG0gKiKWRDnw
	7qrNGf75NrjMgz6L4e1tjLFpJlmN6CYbkA0p52259tCM0uunAoan95dTqiHx7w4WpB3JgD/7PE2
	iUEOXFd3Y4Hck77kxc5jjTQ==
X-Received: from wmbje5.prod.google.com ([2002:a05:600c:1f85:b0:495:48e2:3e83])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:628d:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-4980c64e4c8mr370772335e9.13.1785852240750;
 Tue, 04 Aug 2026 07:04:00 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:23 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-9-vdonnefort@google.com>
Subject: [PATCH v4 08/18] tracing/remotes: selftests: Prefix hypervisor folder
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename the hypervisor tests directory to "00hypervisor" to ensure they
run first. This prevents the hypervisor tests from being interleaved
with other remote tests which is confusing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
-- 
2.55.0.571.g244d577d93-goog

