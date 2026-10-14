Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52478305667;
	Wed, 14 Oct 2026 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020137; cv=none; b=n+elqEzhW9YatH1H3Hh96XP5VXf4APasOayMeMjD97B3y7lV40C0M7fZbGQhpKhHTfS9K9Dz1dWlDPhNH/DU0qYiNt7zAbQLGNv2R76YJdCu5WS4jv36ykOPKLXzkID0Jt75vQzHrrOQ6An1lBsNtxwppb/Bt8a2Sp3E7WeukEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020137; c=relaxed/simple;
	bh=nezIFOMIHe5BTXgdZTRDRTmir8o6ahnkOGBaXIlH7jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=IQUEbFo4uvnz0KvUWriZ9qmQKLA9Vhw/6IirL3XZloE2rZGxXYc0Wpr3zmCQf28PTtYOywhnKHbqOOcSJkGYKNyub1UbzD3bobQA8p8Lld0nOoUdk1twkMr95b8v2n/MJ5omT/GKa45s4LXy8SXVi6y0F2lz0EwQZaDc8IOR6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GchSTDKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GchSTDKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756651F000C4;
	Wed, 14 Oct 2026 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792020135;
	bh=VD1J8g4gHfJIFTkXY2M7IHzffrijTMqnNdYdZxb2K98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GchSTDKUVGSuAq7BxuUgDhdFZ9x8aYWt6zfHFNkgdqO/I/NnBEcN2JJxcAzwnKPtE
	 iQ/s2ark7H+Y9Ys7TLn9Uds0r3tE1zKAfEQ2cEvz4i6SpaSxRR9sXU3eiBGqAiCY6i
	 Xt3IzEL/mG3vcUkk+ly4WKFnQaIoPlH0WaHA2e2rfxeyt7RINzbzzhwf2bQHS5XC7p
	 8jfGsKcLuKK8YONS93+a92jKimqHD1lnNvHYidF7TUGFme6YAh/wPdV2l9zgMFgQkb
	 +jZ560uNft2xhEX5uPbK3Sck77PRpaVGG/LBIEapt4HCn0yOnKdKyj2w7/GfJ3fD4d
	 9ITAzZnMCdUAA==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ring-buffer: Use subbuf_order in available memory
 estimation
Date: Thu, 15 Oct 2026 08:22:12 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261013102047.1488347-3-vdonnefort@google.com>
References: 20261013102047.1488347-1-vdonnefort@google.com
 <20261013102047.1488347-3-vdonnefort@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261014232214.756651F000C4@smtp.kernel.org>

On Tue, 13 Oct 2026 11:20:47 +0100, Vincent Donnefort <vdonnefort@google.com> wrote:
> To avoid failing in the middle of an allocation of a ring-buffer,
> __rb_allocate_pages() looks at the available memory estimation with
> si_mem_available(). Use the subbuffer order with this estimation to fail
> early if necessary for ring-buffers with an order > 0.
>
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
