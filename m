Received: from mx.kolabnow.com (mx.kolabnow.com [185.254.79.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C752DF6E6
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 May 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.254.79.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175818; cv=none; b=gbVyYReAHMZZ2uhunHdoNcxhOCpLemWv837nM5b+2EHhGS2rIseX3bcA6iZERXvBOSIVx75XxPM70jXqT2sv2ZgRzwFQxeAWYTYac/jvWOlxV+YssE2ZZb6d2zBSuNYiBrqLlhsxcaLa7EmfWnCiADQxLOid2r+pjrCVeL0+scQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175818; c=relaxed/simple;
	bh=D88owxq9Ze6civeY8QwnxsHQYi6XvR05xzlHYSxdF1s=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=gJMunPBIzLeTodheBKLhSZ3lI6/q2aG/mA69mMLecjhw85VJnir/wSyTqwgMM8bYUHwooS7PRV8W3HQTka3AlASfj4F9gU15Nt/8oSohnVaBGKhLNwVNJr4ST6WJfwltNbD0fFFAumznYG+jWDOeqrTzTDnrXBOj9Rx0pSkKz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hansg.org; spf=pass smtp.mailfrom=hansg.org; dkim=pass (2048-bit key) header.d=hansg.org header.i=@hansg.org header.b=HmETFgDK; arc=none smtp.client-ip=185.254.79.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hansg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hansg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hansg.org header.i=@hansg.org header.b="HmETFgDK"
Received: from postfix.kolabnow.com (unknown [10.17.5.252])
	by mx.kolabnow.com (Postfix) with ESMTPS id F093F30DA753;
	Thu,  7 May 2026 19:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hansg.org; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:content-language:from:from:mime-version:date:date
	:message-id; s=dkim2; t=1778175244; x=1779039245; bh=D88owxq9Ze6
	civeY8QwnxsHQYi6XvR05xzlHYSxdF1s=; b=HmETFgDKEjF81VRRrNp8CgP4+dQ
	5IkzMZHo+rcHH+fqCrYOIoVt4v+FVdsobRo8CXdJVvoQA4ORdJ4FPgwBwsudpkfz
	j4Y8lYvcH426qLxuDSuM7s0AU5uhJt0GFFBjmu80xK9DbYDBh0lI5aaGqJ2DVRkH
	NkD0NmKCbsGEH4lc0LlIvmTYC/XNFYggx2HSOlRkVwjZRchZesjBwVxIhqujHS3J
	Iz8pthxYUn5tQ1FMO2Rxnt/35oIA9UflZDIHjPUzZHqr/dxGSkvSLJ8qJqGvohw0
	4uY03Q0L/2G36A2nt+rmBTdKEiLcNw5w+HHsBKzthYp/CR57bxTtExP2+AA==
Message-ID: <8574e496-ed2e-4057-8614-726d079aac57@hansg.org>
Date: Thu, 7 May 2026 19:33:58 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hans de Goede <hans@hansg.org>
Content-Language: en-US, nl
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: CONFIG_FTRACE=y significantly slowing down module loading
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Everyone,

On some old hw CONFIG_FTRACE=y causes "modprobe amdgpu" to take
25-30 seconds, halting the entire boot process for that time.
Where as with "# CONFIG_FTRACE is not set" this takes only 2 seconds.

I believe this was reported before by Mario (in the Cc) and there was
a fix of sorts merged for 6.15? But there still is a significant
slowdown (especially on slow hardware).

I was also the reason Mario originally reported this and Mario
asked me to test 6.15 but I was busy with other stuff so from
the better late then never department I only got around this now...

I've tested this on 2 admittedly quite old and slow machines,
but the impact is big enough that fixing this might also help
speeding up modprobe on modern machines.

This was tested on:

MSI S270 laptop, AMD Turion 64 MT-30 CPU, RS480 iGPU
FUJITSU D3003-S2 industrial PC, AMD G-T56N CPU, Radeon HD 6320 iGPU

Both old machines where amdgpu.ko auto-loads.

Kernel/modprobe real-/sys-time/FTRACE Kconfig enabled/machine
6.19.6		32.5s/31.8s	yes	MSI S270
7.0.0		25.5s/22.8s	yes	FUJITSU D3003-S2
6.15-rc7	27.7s/26.5s	yes	FUJITSU D3003-S2
7.0.0		1.9s/1.1s	no	FUJITSU D3003-S2

Regards,

Hans


