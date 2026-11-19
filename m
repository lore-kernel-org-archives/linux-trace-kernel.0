Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795088156;
	b=a3FCTQjeVBrfdY6D1oc65QU1y2LqlH0TUr8j1eCu/XkPlKZh/qJ9NapfNpQ+kSa5GH/u
	 YSy5KIMOPSkOu8ODydGlVyv341d4ePXcAEM4eZ6QcK2c/l1dAM9bVog1AZWg5o5Y0rU8x
	 smdD/6x/FKFemWUW5djnjujkTJvCvqtWxAAW57kDM01ZEsNPUUIwy5EoLqrDm3IMU7V2t
	 d2xdn8tTAU4zBw5k93LOy0PfEPlSxVE8Lgg+0e5zCe20x9P89bFRINnUsLeNCt0X0HtIM
	 j5f9kcV1UFKbplPXErYyhl21VA4mJjaHsdIGaoY4EHJcX/no0Qo/S5+xuH39rETzWpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m7U6M/EGmEZmxU1yvdQ7vVBYlQ+ST0xMHMaAKZhcHEc=;
	b=GYZP9W6erjKX+UcWIfEoHeZzgwetoq9OUoXQXOdSAm6zNR1ZfUfyQtuEBQT40yqPtVHO
	 Kxjt6hQ9nrgWXEjxoxpYoGljamJItXgnq3J5dcC/jYkeXAni1m8zPdMDR/W2q26nfzgpr
	 XwCGXC6ynEHoH/RJJLxk8e7G+vPFjNYRzE+OWC6xLty3yz0I7GBTfr4FTd6gG5Te9ubxN
	 ReQlsfb0oPEL1naxPtvD+aZ7Cj8EQhN9GPgVpoXLDbfIJvHhJfELI+P79ratX2ZWnAsXj
	 1zBPzZSUlGHbMtHubQHTO8mM5QpEzSLC0Tpa7zqnZ386M8jXn2esKeZZbrE3WOWy31Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=QcPl93oW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10751606A330
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 11:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10751606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=QcPl93oW
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-89ecfdbe443so252696b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 03:35:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795088155; cv=none;
        d=google.com; s=arc-20260327;
        b=niGM7D3GyCHwrrLojrkZY9Q8j1TM8B65AYIiecyQELmei7ogrQwv7EocIqcBgs3qz3
         7AbFQlDCb9gtVaymq+XCuPDSC10wK03xuSPPkFpAug1/4xUroi5ye9IEaIY68oYb8Qqc
         QhFz6kKSM/06jfSkucnkF4fbsHvek+dTyc4GmX8DZqF3MMi6ZS8bWgoShiwP+7KV9xMB
         zJZwX0NQeWFnBNfCAxFe5Kv6R4EEAd+nG6+IVPz2txCbnNhKktPFWwcm5cn8gJbV0HwK
         dZjVURndV/YQC8E0v/lsRzg80ixisq1y6iLRjCQqI9jnLsgRKd0intuJUNrOy43N0GhD
         AlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m7U6M/EGmEZmxU1yvdQ7vVBYlQ+ST0xMHMaAKZhcHEc=;
        fh=27/gubao05JuaAcabhcRkhUcTyCbh95/W4PKDWdthZs=;
        b=X7xSL+y/9I30Iqp9oXOYNxJU7/gZT+/cYlr+VHmFrOoDOp/UEXuw9lXTmmiJk+YnzF
         j3GQNynuk/kJ5LZZR6soBZIHIWAY9f2BmNlZG4VzcLxuZmsT3qexwsLIeWOgS2U2d5p/
         ChemVBLjOK0YcSshFLGsZDPz2rE0LdeTHwEbUOz7nExyAM22ZrZJrEnZFQswR6AfovpM
         yJ9dZW9BJoz1/b28xzD4VYhdTWQyTCpoOYKhl5zT+h3i35iPFr+paKO7nu9+vM5VFTts
         MLdAwPmGcTNMc3qNgFPmY+YSUWzVjQxHv5miV6UOcPja1uD535WnvClimEx3E8HWROFk
         7eww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795088155; x=1795692955; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m7U6M/EGmEZmxU1yvdQ7vVBYlQ+ST0xMHMaAKZhcHEc=;
        b=QcPl93oWLhCfA6leBBUG94g8wJ2Az2pfkebXkNqWqxr2f/4hbVCjDTxj4Wsgb4iD0r
         nGkRNlVXyaMag+N4sHAeLhHr4fFYUg51fIfhQLYNgG9/GzgqFiZ/4fjhrEe09ii5oSWk
         t8jvmiKoPyt6+LI7wNnxBX1bCvgbLK6ZjrZQ8f04aTDbIsVzjFvDiJfWdqNiN7iZqfVZ
         Z0SX1IEAeCCU8Nlb7V0FyKQBiCaDad+dj9zl3js/OW3CO7QzEZkdeWlSdf6r+naAIr/A
         FCCOZPjt4r6600Vq04BoxThCNOBtD+fxBkHJ75npg5p3lqF+E5+ObmkVKmoawWEJNj0V
         BfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795088155; x=1795692955;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m7U6M/EGmEZmxU1yvdQ7vVBYlQ+ST0xMHMaAKZhcHEc=;
        b=GFXCBY7VY6TK+gnD5y4NP7jcdxHkOdmQ9bAjm8Xw9rprUhyw5yWb8aHwCWWPEhledg
         9O/2vaC+9NjXzH+3DzoL9CcrpyEY00Kc+NUaMmIS5k9do25LR5rL7O8+GvVhPCAogqsv
         UPdZ55VNDBM2ExgowQ8cv8jQrVLqWcgiwc9YpP3g9RQTQCTfdhPLRRTr0pvIi5LPHH9D
         WKKW1V2LccQXPzXZYGKSJbCxlbLHg/Q2Klw+KOKHHJAWga+Jzx50pwmXUNza7sQyAQDO
         KcdxFOGs8C6CwiKgpX0dnx9Jw5Nk/HL0cFHVcbY6it7M1litzLIUOmDa6PmHBkYsILsZ
         Zmuw==
X-Forwarded-Encrypted: i=1; AL+hErHkrG8rbJIGBqpxFEyMIL7vOTkriX3FK7LrNoF4Ewn5HRofQayo0qyS+0KUPAx6yRKdQXywFzCj0RKPktHs2k34AF0=@vger.kernel.org
X-Gm-Message-State: APuU4Z842TBliaJVk0GZbh8SrpiGn0ZiwwqbPRUqgI7g6GbWnOv0vMY0
	duDhe0bS8OYUyUnRHjd1H8EHtV5VRD0yCktMrucqp1Lt97Ghgyus/tkGAirCehw+cJdaIjEPZnn
	SK+YziR8XRSTPOfUKqKOLLcKg7XjTRXGtXsGwRfnFOQ==
X-Gm-Gg: AZFdTZca8uyx4JFtz7yiNQhJa1cHCDEe78SsZMg9/wvLnCxaXdzu7xjB6JjRhhjpUhp
	yduxXIb7j3Sf8TTn8P6ZHx3QzMtsbLqIP6ij2f7ZoB4PISfuOgHvqf7t9C6oQSPnI8r27R8TFUD
	c0GPYYG2h3PGyDCZ5vqnCuHaFAAdlhHhKMtQzjMZWd1U6U0cqrOum9arI06o4BEzeHDDSMfx2Cr
	5Ds4nA9DeamkNrJDfVaH7bmWh1yzQvMz8hzTRFCPZB8H+rbSpVmkfaR1LdurJsDXqoLY6TcINm3
	yPGWhWA6iZ3hz6GV8xUNA98Tn4a1L5XY9o+A+jbeIHakTNPKYQdTtnlDnKD2QayUOkwbZY186WR
	dYb6gE57FPY8y+a2hCCQLeF74Ywa7Af4jc2a5WIaSjUXRrIjrLFBrXhs=
X-Received: by 2002:a17:902:e888:b0:2ed:29a5:782d with SMTP id
 d9443c01a7336-2eff72e15f0mr91673755ad.2.1795088155325; Thu, 19 Nov 2026
 03:35:55 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com> <8fa7eb35-950f-49c4-b60a-c00b52cc6e4d@linux.dev>
In-Reply-To: <8fa7eb35-950f-49c4-b60a-c00b52cc6e4d@linux.dev>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 19 Nov 2026 13:35:56 +0200
X-Gm-Features: AclHuK_P4lCX2n9SuYxSAwroQnE6rqvhil-JFhCxhFnQsc1M0KgmmeelNAQBEi4
Message-ID: <CAPnbwjpaTwDH1GqV0Mxtc6VOL7feWTBrQwaMD5bzq1kzDmE3vQ@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v3 3/4] bpf: Check program
 recursion per task via bpf_ctx
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, tyler.wilson@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"

> Was a limit on chain length considered?

My proposal in the v1 thread had a cap of 8. If it turns out to be
needed, I can add one.

> did you try the array-based approach mentioned and compare perf?

Not measured. I asked in the v2 thread whether it is worth doing.
I can measure an array against it and post the numbers.
