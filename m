Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DDA35898
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810415; cv=none; b=b3zpwYvajVYROOq5IkIsnDAsZQtEqNW+2uy+KEJIkzqvnfMZTyYiD/uRlOktfTdS9PwTUWtZB4qck4Le7yHuRAfYjZWYTQBkj62OxdWi6Kk9L7cM53mlRZQedYaFOraMSQszHd0EF/pv8C/QTaJgSMA5N24HUZF91GyJjlsorkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810415; c=relaxed/simple;
	bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCo7ecQmtFu9V3OX961WEhVGgKgOaG4vVOEiN3eqweHkKg00IBaRa/Syn47Mqzf7o6fYXYmcfDA4UuoefM0WqJX2i+xOL3nieKPqPS4jn3YuXhfyCa/zsFt5lOeE1MdfTmegXvBW8HsPWr2Iej4H0iI2wEkXw+xBy1gzAZcMDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SCU5+M4o; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SCU5+M4o"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7490cb9a892so1155841b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752810413; x=1753415213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
        b=SCU5+M4owUAq67eGL2xlpSBkeKyUhA8Kq6XFmjO1BLZfka8BYKq+K2rc3Bo9ToKIwY
         rXa23Ds4JToursaj7bEhWeibslzDKQNPDMK9HM55mwP52A+LNWvPuhu52cS+KJm7pnCw
         Y+pN3TUF31U/sgTLEBooIErRvCdG6EXB1KlyT3JZZkBwIyXw0y/HkjBkUlRDj48MFEjZ
         g9hJxDdDlA695w7GTsRlviDeMJzVfasC4u48WhwQ/I1JCI4ZkvuV8ozlFgJh8fl1j2NA
         Ku2F66+xxyXEupdjqYNtkdqa3JMYqYPyA38a5sEuX32XOVMl5ZJi01rjj8Bo3ruXNfbA
         6s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752810413; x=1753415213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
        b=ISf/b/Yk9ZFhQxjJ0cagTI9q8PeDpgFAdZPu6g7lfLguUtAdbNF+k227uO5sFRvKYv
         W7OmGsRC5kV0kvRjw23vqXlajW3xoFas68oM0Q/z9WLZEiz7THx3LlJ1ZLqpllzLmu5j
         +NaFE/jWonUsDY6MeREm/v2UzHl7L2tJOvKLKb0pwTFbaLY9xLztlWlTcO2JaoOr/b8g
         3Jn6UcJTW0/hPXJtB4DW0uwY1sMj49birYOzachtmiFksBb/tjLinX+Ea9HKc3H2KiSb
         zNBztJ4O4+tYz8BSZCqtDr2RjVmnhYG4pxze2x+tRW6JYPAxn9x8XLMbXadozR0EVYwU
         yYZw==
X-Forwarded-Encrypted: i=1; AJvYcCWqAB1sTaQ62uGKqqrYzGIxK28CLiOTzh5LyOs34eVnOxeK24FbgxZxS5R8PVlpWozYMb4IAUAcKccfonxKIbbLZso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0TPtKMEbu4RPQes3ClEZ9W5gkL1nmfJ2fO/NGodrstyCve3Yt
	y1aq2XszYxWjC4rqpELH0KKKn4cDArAOtxv5LOKI9heLlZHvaCKOq9ygY+Z/WeeMj/U=
X-Gm-Gg: ASbGnctC5M47lry3qd5wy0iCJYGA+eCbxb5VnBlHo3YTpPxh1Kgi1RDsASa0D6VkkNK
	GrQJL7JQ6v+dU7ce09ohC2NTr+70sFkk1AZB2DC8DV7jl1vJ+GRSYSlrL8KmPg0CHGlsDH16vSL
	X/nr+wMde3flINpZvj3qVFzwoRole59N5B+f2zTWqpXg3ar6QSgOsK3KCIeBvKwKaTzYUTjaKdb
	7HkkNUEPf28w6qh0L+nfKNV8K9UDYMOTwBtnTEgyMFzRDomUmv7APjL1SkEwDKjXbNAq+PQJ87M
	zPX67ggo8x/svsoVdGoDp4EtJ5CtSEU9Ib5C6VDNOdVHVWTjjXRXS1JlJsHNLGxhh+/WP4o4Ho9
	HqBYeNoWGskvJp8vKJrIvzUgPi+LYt2AdMiNekxkS4aQXXAas
X-Google-Smtp-Source: AGHT+IFNa+EcH83FNXnjEm3C0F6TihGjOc1OMxlRUqkqp/V85onlhfwD3tW3WOOTiHm6RK2tC/cZPA==
X-Received: by 2002:a05:6a00:2189:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-759ad4002fdmr1963419b3a.11.1752810412983;
        Thu, 17 Jul 2025 20:46:52 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-759cb678d8dsm310811b3a.110.2025.07.17.20.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 20:46:33 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: anil.s.keshavamurthy@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	davem@davemloft.net,
	ilpo.jarvinen@linux.intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lukas@wunner.de,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mattc@purestorage.com,
	mhiramat@kernel.org,
	naveen@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tianruidong@linux.alibaba.com,
	tony.luck@intel.com,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Thu, 17 Jul 2025 21:46:16 -0600
Message-ID: <20250718034616.26250-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250717235055.GA2664149@bhelgaas>
References: <20250717235055.GA2664149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 17, 2025 Bjorn Helgaas wrote
> So I think your idea of adding current link speed/width to the "Link
> Up" event is still on the table, and that does sound useful to me.

We're already reading the link status register here to check DLLA so
it would be nice. I guess if everything is healthy we're probably already
at the maximum speed by this point.

> In the future we might add another tracepoint when we enumerate the
> device and know the Vendor/Device ID.

I think we might have someone who would be interested in doing it.
