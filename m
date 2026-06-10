Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0540B387
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099096; cv=none; b=BtLGkkb9xl2J5UsV46CbuXRo958qJ7dFQpvltDGCmF+xPWvybG5S2utqce4eqlBL4wLUpUom89Nrc1faRppW4FTq2XBwxqG2A5hxGd1IhaKwbTFnk67rCDffLzLecE8z4xa09JAxs4W5oqUfsWDDPWrE1SLsHQoFKFvK0kH/eTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099096; c=relaxed/simple;
	bh=pIKr+f7SHAgP+TcmEWYNDpdjqyrYirdvxHbiE+PC0TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ve5oUvHwRu7P4a6INfVCPzxpQnv48enh+VD4AWuZFpB4kZGPkxEu2Np2zMH+Y165Ep7V39u5LSNIP69UsPceb85IguJrLVx/R9xAdeXiD7Kd5JC3c7d/YQ8MWwBYrWzsFufKIAu6DStG3KxFa974xqRqP9WqKy9nsjdb7ime2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyAZOCpQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyAZOCpQ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso3501771f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099094; x=1781703894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yJu4GWXEjspPhIezkRFpn6+hkFDzwgslLfP1rS8cOdM=;
        b=fyAZOCpQvX1+UQaeAf0tQnTOD1n4Sjo0MTI5Q+XLKy7sgQW+wQNiShywFvjwARusPY
         1DU4dxJnAG4DOgd6eXds7D7pG3i+ANkDhgZZrfgqiNOm7JNPoA67eey9Uzxye6TM6OXx
         6F20MRiO4UCJwy5m4nuc/kLg0zFrh6njTfV1Urjctd6I6FWxrcUuKHDztt5tyOm7wVZ+
         Qn8g+d/lpUusVQ57hsxMvUjzfuohuxTqqF0mznYN9zL1xqJq9VynoqfPpK7JHutj9iTH
         uCRlcDchm2clSvgQYA2cUIQLDvkL0lZfyUuBtDm2SFz3NiI4Lcs/vl7ORvMqiP5efBvm
         pDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099094; x=1781703894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJu4GWXEjspPhIezkRFpn6+hkFDzwgslLfP1rS8cOdM=;
        b=J7nOZkMQq9Tmr0eWNaal4IJopZfwR1P3TW823Wq/Pu5LvQK/3UkoSjWmA5/VQyG626
         kGjtnRGiWqiAnJh2ZLUd8/OuDDiMiilJIHm9oTilAMEQ+0DsoegHKO9DeltegsyYC7UJ
         S9W3oEcIiwaWBNXB7Y9gvWjjH0tIM1gqQuHJ/hnlLBEcup/L2uSalhQcgtCmmXI05Pl7
         SrNDPzdCMiwm4RgATf7I11uA72TkDLN8K/7yWC7l01GxkZ5RJBm0mq2Y/4O7eQoCT6xV
         8JeLggJjQu4JkxotPeOHqHbfgu+umvfB/eXRYi+2QCCIVKxqRqPurBwwuVQ8i+26jpYt
         /Z2w==
X-Forwarded-Encrypted: i=1; AFNElJ/bR6W4TuveMOWG64Cezw152trvmmUAO9jlugqaI/RqsO7qil3MTlGtYE8FC97WA+XcT4ZYcdhhZYmxcGp8RxhXovw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdOkrs2XoNwUegNWrl2vZKgEI3DzBwUUR+xh2wcZv84kD3rHa
	M9lYL9Dju0+Ou+CW/bNtDfBh8NFs54GmezngWRMr6wxMpnD4byKuUen/
X-Gm-Gg: Acq92OFjWo8q1l6h0/+Tyt6D+fLTFDphN1EyN5zs7yNbNbKtnyRg41ejrpuNaQ8AF1R
	248hp9hP38sdBu8hE3AJImk4vUgYFozrC23AcdGKd2WT5sriAbjw+iOygl0LHLOg7UzHn6QyJjc
	0itJBH/D5w9oVz3LEX3ApckNLmOuI6ViqEyZDu2mH9CnGAy4O9YpZUDSJpvqZ6oz/jzgX+YUNIo
	TbUpxie1dPNxEJ3oApCSw24mvNvxp2Iul9e/gfqGNLG8iZkJxNa+KSgfv4wKuDVmRZFDfPlR01P
	vOQ9PqUZTShyey8sefjcAlU8ucwPWfh+guRMJhjHbi3sxdW4offMZckgBN/LSDbOW9JUWbc8KS/
	+DlwqeXAsaH4ugFmMFdyqO3gzhXv1wN2eS3+I6wlxwDapXlDQlExWHLwErJYhxoexUokKmokKf5
	jAiHwJY2wGguVvXfFZm9OVRVqf3jWOGI8IYf6UoL1KztzbRb4QP7UDtligcKpLz05oNaBQltlYG
	2et3YiZ6x+lVom8Nhl7eoNgjWj7GQ==
X-Received: by 2002:adf:f183:0:b0:460:1e5a:2267 with SMTP id ffacd0b85a97d-460304e8b9bmr29117746f8f.17.1781099093784;
        Wed, 10 Jun 2026 06:44:53 -0700 (PDT)
Received: from [10.128.10.215] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm73852062f8f.1.2026.06.10.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:44:53 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <ebb4fb1d-effe-44c6-82dd-8223b36419a1@gmail.com>
Date: Wed, 10 Jun 2026 14:44:52 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] bootconfig: render embedded bootconfig as a kernel
 cmdline at build time
To: Breno Leitao <leitao@debian.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org,
 Nicolas Schier <nsc@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
References: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
 <20260609-bootconfig_using_tools-v4-3-73c463f03a97@debian.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260609-bootconfig_using_tools-v4-3-73c463f03a97@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 11:28, Breno Leitao wrote:
> +	depends on BOOT_CONFIG_EMBED
> +	depends on BOOT_CONFIG_EMBED_FILE != ""

Hi Breno,

Just an FYI, this dependency on BOOT_CONFIG_EMBED is redundant because
the:
BOOT_CONFIG_EMBED_FILE != ""
is only possible when BOOT_CONFIG_EMBED is enabled.

- Julian Braha
