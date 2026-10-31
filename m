Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466609;
	b=on546Pj6GzKgNxQ8qBA/dHWtDEtKFlSowtvbKc9y3D9EXi7abre4DT044ct4ae2dAzoT
	 bFbq0gb8Rfk7xR2XOiZzAFDXs7CL9aKQ26uDxgdWUevtbVrzRhaZPencYOE1gOFsTjMBg
	 lAQyfmcBu54loE/TTTzDe8l/nmbSNBc5B1HEeNBrDVKfnfzYXPRQ7VWG1E+7lzGLZz+26
	 efDDYV98uvHTeROkr1JjjAELiCFo36HHoloNJxfQKlUzE/IGUf3WqbrMPoI8WPxHNeqM7
	 R6OPvguIez3Z72M2SUX3NBc2HREzhxAS8pfzAY4WhfGhq4g5hhebHKzUMK6OcrcPngA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=S02zFKQTw98qLAlbNryreV97fiHHWFWx7ndQG3y57t8=;
	b=yQQa7iKj3D3T3lK/yDr+GUkf6p8hORJJHztqxtOgIw94MqkpcrbxowKVp7Mi9PahqlcG
	 zko9fFYwHbK6MiUEAw3V9MRCt7hEN8/nhrtCYZdzcoIrIFobqgE3BTzZycUgwmJrq/aVu
	 0m2clJdgYqDG6b3xDZnMc+lMTtAHXP0NIBLcoYTZu6xzxbYSe7kix+4dSmGxb/o+G29TQ
	 pjTz1RJAi4pprV0Cnwlxvnyx6riIgX8ObqJamYvx6pa+CNRNQACps2/ch5ilohj4YY2mN
	 7whYs6pZEHaSnqw0JdfGAW4oYlhDEssj8eMGeUJKWz4fO8FgSIoXsheV/FYMxYh+e9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAlQpn7V;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ACD606A324
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 17:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54ACD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAlQpn7V
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1090907a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793466609; x=1794071409; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S02zFKQTw98qLAlbNryreV97fiHHWFWx7ndQG3y57t8=;
        b=zAlQpn7V5Yxzz3a/EooOjbQS76Q6xQ0YpJEIcGp4YzdScOrPhhAvrUur4/FQHYJqRA
         8zfHghpz6jXKETFWCpI+22lxZ4tiU8Y1Wc2I1LGCzNcA48QIfHM0NthCxotitdxVloRD
         7jW5L//FxVzW4EuToHyaxOBM6p67ZQEXBbXMiVGM13bEtgPc/LRBcWVgFZo7OtjjXbae
         x38X4P6bQH9CmqpDSl/U0Gq7hPzrHgec0DsPUl+NFmdA/2pRimxjub456nrjYLulRtoc
         kY3kMmeFOtp3fe5XwkcAgy2f09rE2oqb/7WSkbZ5wd7smSeRqi0JaRIl0JBf3GPVA6ml
         lPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793466609; x=1794071409;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S02zFKQTw98qLAlbNryreV97fiHHWFWx7ndQG3y57t8=;
        b=xb2TD8wJr9I89nCdRofHz5j1ZvMe5jd/rHKt485JbmWRbdJCF+NnWOMe7gWYLSp7/9
         MDbgaK9TaViMJWE27q9nPM61qMJhPiRDqxLoCKuXoY/vgloRSD5hc+SiKn4KwGU191HZ
         L7W0RhEY2u91Kkm7yUW6SUE20GEXu3+Zv6wBWrPFPyru32Bugenxjbzt1UXDHf/ii/WC
         WcQqe/yNbWdlioAOY9bPbhuBtiiNw8+XjOh2brCRDDSPgM0HZIicZB0Kyzi9QJPzDRzY
         QBOlYlX/cSlADeVylb33gPaRh8ETxLuSAP7yHqUnODEEPQCSGmaH9Eyjq1eP8ZUrOk97
         d4Bg==
X-Forwarded-Encrypted: i=1; AKwUvBylcSBwDGN82upNGioNDCvcmu/u93gfCEXLfqbz82EDEwQ+seYSrCi2xmcqXU1lWd8fZ7FVgvlvW9et8V4RdOuEHEw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVW6bIX7/rpY5UIDgd6q2O13m1m10/xBmP8Nwb5E3sunPyrITL
	E0yifYRAzGnzd7y15HngmtgHRONoyXFjll8FyUeC38YZlHWKacAtNonM
X-Gm-Gg: AYBFou3pdpP52UptwcpzIeUQhZDiNXW8Qk/tNCgG1C2JX62s8AaV+GRf8cm0VMOeXlf
	3VW+3zTdh/eNRE+7V4eWa1yyDX/Vq4TLIb9SxUzI1QGQ6+HgDrv7zcRwkbNpp990vrxLhd16xR7
	H06Z+da7Gwt876llY57TtS8zNVJKynVwITVDxZpT87bsNRwwC5+FgEXnsvnftC5kkrltx2Bojq7
	TGUMKKS4tnMSB2xaVWbN2z2AbdUmirgKq89dLrSZvJq1WbHEISvL13MRruFCP9hoe35rAsW2bwg
	d4zSoVyye9oI6vib2k4vrkJwV7CJeQXssCc4xrvdzwhueNfQnCnC0XMuxRs+NnLHP0spNObkvwc
	/9VpLHTVuJ79MN9D2C/EFKQgehDkChJ6UoPWYudWehipZAL6kSOvgXJMBczQ/bx9BKQVlseU7iX
	4FUvL9D5ZaoX/60rPjTi86XQEjfsbtmwMcXOcZRcTZ1bLBjAfSmaVOqO3STsNmWLBLJJWaMAWmc
	ZiJtt6H9WZrsmYhTIctxTmg6HhwaQfKXyKky0qY0KDcp344jOQKpuh0JnXrS9oi6yVpR0Fs7nUG
	3JJ0Oodi3yIh8/5Ut+v4TlA8g/HyoWgCLpkJiuKjTqIe+o9Ef8hOMnXu322nM7F4W/leJVAw7hI
	gW+9minzjhy/Fi0cHk/Vzcw63y1D0e6HgGw==
X-Received: by 2002:a17:90b:1a8b:b0:3ac:9e76:aa76 with SMTP id 98e67ed59e1d1-3ae8970fd9dmr5106038a91.13.1793466608564;
        Sat, 31 Oct 2026 10:10:08 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845df666sm8093713a91.14.2026.10.31.10.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 10:10:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 17:10:07 +0000
Message-Id: <DMJ6UP7FV1X1.2E7I2ILPBS34P@gmail.com>
Cc: <ihor.solodrai@linux.dev>, <almagui@kernel.org>, <martin.lau@linux.dev>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <nathan@kernel.org>,
 <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, <arnd@arndb.de>,
 <linux-arch@vger.kernel.org>, <x86@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <abuehaze@amazon.com>, <doebel@amazon.de>, <mpohlack@amazon.de>,
 <jay.wang.upstream@gmail.com>, <martin.lau@kernel.org>, <mason@kernel.org>
Subject: Re: [PATCH bpf-next 11/13] bpf: keep module BTF until the vmlinux
 BTF is parsed
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <wanjay@amazon.com>, <bpf@vger.kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
In-Reply-To: <df56aa51cd704ab9a9b03d3574e6ab4c61d5e6d4cdddc17f4b0253f67cc077da@mail.kernel.org>
References: <20261031130959.23472-12-wanjay@amazon.com> <df56aa51cd704ab9a9b03d3574e6ab4c61d5e6d4cdddc17f4b0253f67cc077da@mail.kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Oct 31, 2026 at 06:55 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +/* Undo btf_parse_kept_modules() of a round that is not published */
>> +static void btf_unparse_kept_modules(void)
>> +{
> [ ... ]
>> +		btf_mod->btf->data = NULL;	/* the kept copy */
>> +		btf_put(btf_mod->btf);
>> +		btf_mod->btf = NULL;
>> +	}
>> +}
[...]
> Can a module BTF that is rolled back by btf_unparse_kept_modules() still be
> reachable through btf_idr?

Yes. It's real. The NULL deref in the inline BTF is real too.

This is quite heavy. As you can see both bots poked plenty of holes.
Five of them are in the -ENOMEM rollback of patches 10 and 11:

  where                        what goes wrong
  ---------------------------  -------------------------------------------
  btf_get_fd_by_id()           takes a ref on a BTF that is rolled back
  btf_free_rcu()               reads btf_mod->data that rmmod freed
  btf_parse_kept_modules()     -ENOMEM in the inline BTF removes its file
  bpf_struct_ops_desc_init()   -ENOMEM of ->init() becomes -EINVAL
  btf_vmlinux_data()           -ENOMEM without btf_zst repeats forever

The rollback exists because vmalloc() gives up when the task is killed.

can we run the parse from a work item, schedule_work() + flush_work() ?
A kworker gets no signals, so -ENOMEM can be final, like without the
option. Every parse then ends in smp_store_release(&btf_vmlinux), and
btf_get_fd_by_id() sleeps on btf_vmlinux_lock until that.
Then no need for the retry, btf_unparse_kept_modules(), the 2nd call
of ->init(), etc.

See my other reply.

pw-bot: cr
