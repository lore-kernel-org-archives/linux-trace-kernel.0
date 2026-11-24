Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535458;
	b=Tl5RaekS3BOrHQhTFdVUl1oWS63HcV1k2LS1nNSK0gLCYqRigYO6fFilh3E0b7liuiHK
	 lMKBA9gBna/D5D24HHPO2Ztc5IhY7BWcBDVRNxB0HeJCrdAR+YKdjBconMViAw1o3cDnT
	 k9iBie2DOhiIBGLCJpM+oGIvwZHM87sd7rYyB3cT1NXP4tYnS2RZm6hn0DOx5+HrCuOUV
	 GE/cg9dnf9AZ263ZZ/paNuyyFKwLvPl/AwvaQ//DUf5Z5fAM/Fr5E5GYXr5YZFe4tMAU5
	 cFM8Acf4v5ghv+8RT1c5KmyaLyHfaqjnjqZL8m94B5fYKe0zQLWVogdDQIgSy9NZVyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535458;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=8CqJm7M0yv4/2wYmOKC/zfDe65AOuxRbGrFH0p4VsnE=;
	b=13wscOtAnWV1Z11cHaUjc9yAgkaVkCAkkbfiZmeyNupuYpx/jyxdYbcKdr1Wu5OkbWz+
	 ILbubrJw06ykA4UP+hRSzfXwQ4IUTpzAMc9JhU4aWBUvQ1f6QGBhfeKhHc5A+3gXQgr47
	 QBdCVRmmxAO51uyNq1lEGOONOdfK1S0CtIX0mGzwZki/sZ0BHuqgZHth7R4WlcDZ6feIk
	 O267lF5AtUJXa6m4LfxmJ7kyLPwnYD6CqOHjSrVECTbU6Y9kOWVr5DE7PX7iXhpTEIT9j
	 jL8XKiIr6rSEAZRPXsy9NEDjMemqnA+d/2Rz9xJ08rzt9HFgk3aXw11U1sdTIxhpxPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ciedm+7r;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BF7606A31E;
	Tue, 24 Nov 2026 15:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5BF7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ciedm+7r
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 8A3DB120A81;
	Tue, 24 Nov 2026 15:50:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 0DECA20029;
	Tue, 24 Nov 2026 15:50:52 +0000 (UTC)
Date: Tue, 24 Nov 2026 10:50:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sarah Emery <sarah.emery@canonical.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, Hui Wang
 <hui.wang@canonical.com>
Subject: Re: [PATCH v2] selftests/ftrace: Account for 8-byte aligned
 trace_marker_raw events
Message-ID: <20261124105047.23c39b69@gandalf.local.home>
In-Reply-To: <20261010234645.173550-1-sarah.emery@canonical.com>
References: <20261010234645.173550-1-sarah.emery@canonical.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0DECA20029
X-Stat-Signature: 6pjgmfyk6na7sr1sycakuaamwqz1gft4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+5ChBTssD8JBhJ43i6DVvb8POD/Y8N1Yg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=8CqJm7M0yv4/2wYmOKC/zfDe65AOuxRbGrFH0p4VsnE=; b=ciedm+7rPzFY39V1r/cvvdx6q6owk4Jag/6O4PoItZZzFzqanHP688mg9Gb5Oh8DAIl5ElX9hAGtd4xvwVtuDV9KZjYwhlR7kx27PvdvmP+Hn1s0UF0bD6uKGSJDi7KdS/Byl5VkKUQjCCaIb7h9lirr4Xi7kjsIDto1Dd0T7k8=
X-HE-Tag: 1795535452-708807
X-HE-Meta: U2FsdGVkX18/ONp8OX8bgHDSKuPF05HxfDxMiVtEkw4nm9gPOmmhU+1iKHvaS7MctvvnPU3uz/UK5nWJqwcJ3J9XTxe4VJFueYHSl+dGf6OYjM0uGJcHMzMXz2fLevfyVLDzY3eUWc/c+tkBDKP7vbOCuuXDk2mPXb+UxfTUtFczlcipjLDwDyGWBDrv24U7KBE1+8VP7N9QqokLOns0rBqh01jYqa4AGlTX94+pdZA1S8G99unk9MdLJ2VNBeCs4CvZ7Jkf4E82ucy/WsGULzSJSVvrhoGycWVMWVOIa1xzklSxdH8U3SUz2pseyNEqiP4FborzvJO0mgIkcbU2kxPZwVTqgGHAXFDTaam9QYsZoEBiBFj96GhscrO30peOKpq/guBOaGT4XFlSjfn4Zg==

On Sun, 11 Oct 2026 01:46:45 +0200
Sarah Emery <sarah.emery@canonical.com> wrote:

> trace_marker_raw.tc expects the length of each raw event to be rounded
> up to a multiple of 4 bytes. That is not the case when the ring buffer
> forces 8-byte alignment of events (CONFIG_HAVE_64BIT_ALIGNED_ACCESS):
> the id plus the data is rounded up to a multiple of 8 bytes instead, so
> trace_pipe shows 8 * N + 4 items. This was seen on riscv64.
> 
> Make the test accept either rounding.
> 
> Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
> Reported-by: Hui Wang <hui.wang@canonical.com>
> Closes: https://lore.kernel.org/all/20260607072431.125633-3-hui.wang@canonical.com/

The Closes tag is for bug reports not previous version of patches.

Do you have the link to the email that shows riscv64 fails? That would be
what you would add to the closes line.

> Signed-off-by: Sarah Emery <sarah.emery@canonical.com>
> ---
> Original v1 patch from Hui Wang was posted in June and only patch 1/2
> was merged (commit c37e0a4b79a6).
> This is a v2 for commit 2/2, addressing reviews.
> 
> Changes since v1:
>  - Drop kconfig_enabled() and the CONFIG_HAVE_64BIT_ALIGNED_ACCESS
>    lookup. The review of v1 objected that it depends on the kernel config
>    being readable from the test environment. The test now accepts the
>    4 and 8 byte roundings based on what trace_pipe prints.
>  - The expected length for the 8 byte case is unchanged (8 * N + 4).
>  - Rebase on 65f26d15f7db ("selftests/ftrace: Fix trace_marker_raw test
>    on 64K page kernels"), which changed how the test writes its events.
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> index f985ff391463..dd2b94be0947 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> @@ -67,7 +67,8 @@ test_multiple_writes() {
>  	# add a little buffer
>  	echo stop > trace_marker
>  
> -	# Check to make sure the number of entries is the id (rounded up by 4)
> +	# Check to make sure the number of entries is the id (rounded up by 4,
> +	# or by 8 on architectures forcing 8 byte alignment of ring buffer events)
>  	awk '/.*: # [0-9a-f]* / {
>  			print;
>  			cnt = -1;
> @@ -77,9 +78,12 @@ test_multiple_writes() {
>  					i++;
>  					cnt = strtonum("0x" $i);
>  					num = NF - (i + 1);
> -					# The number of items is always rounded up by 4
> +					# The number of items is rounded up by 4
> -					cnt2 = int((cnt + 3) / 4) * 4;
> +					cnt4 = int((cnt + 3) / 4) * 4;
> -					if (cnt2 != num) {
> +					# With forced 8 byte alignment, the id (4 bytes) plus the data
> +					# is rounded up to a multiple of 8, and the id is not counted
> +					cnt8 = int((cnt + 3) / 8) * 8 + 4;

Instead of doing both checks, it should check 4bytes first and then 8 if
that fails. Although, it would be better if it knew it was running on an
architecture that doesn't support 4 byte alignment.

-- Steve


> +					if (num != cnt4 && num != cnt8) {
>  						exit 1;
>  					}
>  					break;

