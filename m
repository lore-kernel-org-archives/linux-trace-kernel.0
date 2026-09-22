Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3BE5625E5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092628; cv=none; b=Otww+QjVPzbqcRrAuhAuF1B3f9KRaW7RJXZruo4jrwIvuRLC0JPWVnH65JyPtJq6oY4ENM5XEi2Qn4UQyFO1PDOeI2Vn5f587Rc5knWpE3TK2lE9fv1GuM2sdKctMTW8D0VczYG7psffFJ4Zykl9RWkvPGOWSIpytv+ShM7Nims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092628; c=relaxed/simple;
	bh=jSIUxZgxSgiyI98U3LfbBokr7Op6qXNEjRhaQVim4+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rhJRMEpLOdagwoeCrzSJYj41VAnQPwtPsPhjDk1j+WVXxv0ujyWPSCLZicMjJz6QlHLhx2zEHpFFKbXAaNRkQ+/0le15DnhTHVKzCaAaNek9JrFEZuG7En1oWFkuJYp7mBpR1+hnlS5WMy7xCoEe3zH/GeNH5+txdbnp5r11nbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMHrVbIz; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMHrVbIz"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8674704dab1so65026b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092627; x=1790697427; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+nINCCexQBjGgqV0IoOg5XqmsdvBTBAWyhS9ytlkhAs=;
        b=jMHrVbIzSqUZNI9kWIiJ81ylSNoC6SK75489YGjl7A/VVWhqFrEwp7vu0tLjBIEPHf
         Aw7ZxDcaeLgXvywsQTz/E8IXUSxLkL9T3Lbu/ezmkLtc9qZnQEQS6T1pu+PK3ed61s2G
         96qzNVOARIvNkIJCjJ9ogqRo1DeI9IGKHy5Ycbue4/ZgM9hOLQ5d1yslDoFzwyjVzzKa
         5P+T1tCxpgooygt/XzECd7oTffNnKnoH302wfG8WiwQ+wbafxmTiuaktrsKl5sBqV3f2
         WoFEhwYJsklOCbifxNcT0XB4OoroErEe2w4Y96D8bzfUwhoGLhJrZoJwf65pxqqdI29K
         qStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092627; x=1790697427;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+nINCCexQBjGgqV0IoOg5XqmsdvBTBAWyhS9ytlkhAs=;
        b=EZWKqjjo94XSN4AOkTaIgfMuaAKL4kKNPd30An536fSYqOQI5/d2P0/HLxBaAot1Su
         mHDfXzVjZXR8hN3H7fwe5/OWs0egamvBGtlmDukeWgzNKVXD1sQXLyeeRAmBnSmbzRol
         y3HtWPv8dM85IsKCSNDblpfoLPfA2l182Z1hkedQx7zvMXYX7C+RhShFRBc95UdeR/bP
         Uf2VV7I8WdHETfoWvLb6ALWtqxFrwLNdslMz3jU9eJj0c7S0IX2EnaJlNYhLZVrwpYmR
         YkLo7Wp+ZGGtwftg7mc8P92lbAfTGSsTcmpStsHG4cxfXQKxuNFMlwh6rSqnXCQuJFL7
         4/jg==
X-Forwarded-Encrypted: i=1; AKwUvBwkMxdFynJLN8uuiHLSKyH92cpxhtO5YhsPr6PzYjKK56VunYmj61t1Xf7rK4DudZmV4DmS3EwYd3ZLQTsJfgryyNc=@vger.kernel.org
X-Gm-Message-State: AFuF++lLeVMoCi+/7lqkwz9Jo6w9j8PUiuokWD9IJX1ln2Axh6nreqeh
	i6JpGKjMcqo9z/Z7vuGveg0Il4OEMOhZvbIhUFr9bA2S50V+OltA+Htz
X-Gm-Gg: AYBFou3fx10pvppQVCSuFwKAIq8g/NuFHWhm/uSyHj5fPC71AYr8m1dwwKIkWJ0PgVM
	wKstFPpzkBg7aT/0bVdjh6KxS24SQMlvsev41BOT7v44osxOSLQHH+zS9ERjeqokOtK1z5d8c7m
	3xFCQ5vym8gFJ2AZPlfKPtyiUnz69q1HYuyTCEQgcKilWQ+alxmJ6HQDtdi7bVql23gYEq8TZyJ
	hYjeACymIOra7ba1oDC7n4szf3ocp23VFAzuSm5qWJ1U94+9DtrgLTtfOI9QWX0ETgPj1Ugt6Wt
	QobaH3jj3RlccCHw/slXRzDoE+42nHYxAyFXXJNcMC+vGdsobwDXykTG3YgXfnaKDiU+UKP+6Hd
	cKk5VS9ZDvujBotU41Co3ZMPwdD2EEMtxQ/QsM5lJLLDwpuSzNp0GFXO0l3kpxwojzlUrijKYmr
	+/XCzmQqX1wz4Ejx2JlNboXvXDzD547KyiiralGniICDX/D0feBazjmGOlRz4SCJKEgnTl4w/ck
	c/UvGoMDeb0vxliJEWOBLg=
X-Received: by 2002:a05:6a00:174c:b0:878:34d7:6a30 with SMTP id d2e1a72fcca58-87d1cdc154fmr17054b3a.36.1790092626666;
        Tue, 22 Sep 2026 08:57:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1b0b505bsm18582b3a.8.2026.09.22.08.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:57:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 22 Sep 2026 08:57:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: trace/simple_ring_buffer build failure on parisc, sparc64
Message-ID: <5574c9e6-9ed2-4ee6-a2b2-fb6ee81e83a1@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

when trying to build parisc:allmodconfig or sparc64:allmodconfig,
I get the following errors.

Building parisc:allmodconfig ... failed
--------------
Error log:
Unexpected symbols in kernel/trace/simple_ring_buffer.o:
         U __atomic_hash
         U trace_hardirqs_off
         U trace_hardirqs_on
         U warn_bogus_irq_restore

Building sparc64:allmodconfig ... failed
--------------
Error log:
Unexpected symbols in kernel/trace/simple_ring_buffer.o:
                 U 
                 U 
                 U current_thread_info_reg

I always thought this has to do with my environment and/or C compiler, but
it seems as if the problem appears to be generic.

I have no idea what causes the problem, why only those architectures are
affected, or how to fix it. If anyone has an idea, please let me know and
I'll be happy to write a patch and/or test it.

I disabled CONFIG_RING_BUFFER for test builds of parisc and sparc64 for
now, so this does not directly affect my test builds anymore. This is
primarily a report that the problem exists, not a request to fix it.

Thanks,
Guenter
