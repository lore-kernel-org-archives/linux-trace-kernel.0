Received: from mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C54E0216
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Oct 2026 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556827; cv=none; b=ZhM7sJTwmcgG4nGiVdkXzzDBfVa6NTsEWh2IFTOchRRNlRZ55QpwKJF6t5k9lMUBdxuJBPN1QvBZ8uVW9jUWOokqO4lnEzVGp9Qfm8ivJIv5kaE2we8M8iIK8nLeYwyBblb2fgCWb+oOjKPDqbhdJWVFnXLbfS9mQfF2NOsJyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556827; c=relaxed/simple;
	bh=kRkhnKHKooIPtvjGsD6RS420FhxGLmWSJJncnjDWyh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQ8M7gq391gBku0N08lQmo8JDqpPtW6SroW4AT00pyELBfJJanBbzhFWE1Ule3omQVhxkk0Ztg7Kqf4xLubgMAm0VliDwi/95fkiVMIai3blLxEXeAQsz00+rOLV90n6F32YjpqeeZSDvL3e6yy4xnDVDbuAtY6cWc17OhuGJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K/PkFUFO; arc=none smtp.client-ip=91.218.175.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K/PkFUFO"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kRkhnKHKooIPtvjGsD6RS420FhxGLmWSJJncnjDWyh0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791556823; v=1; x=1792161623;
 b=K/PkFUFOUukOIWdwo4hyW9yeT4SuLoRiC90M1/EDJjoPDz4Ofd3gMZDSqntCnwXvZR99BbRk
 XV5kMDGO2fRdykAw2wrPRIJYoHLmZ12YBSpghNuwpwbTNdaWSwVIk8vcfr+VxiufssjlK5rZ73N
 JIz+/5WS7oimPpAJNUtQ5j3w=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0c4c9b73b46a9964;
	Fri, 09 Oct 2026 14:40:23 +0000
X-Mizu-Trace-ID: 0c4c9b73b46a9964
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcc04c71f5so8301e87.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 07:40:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzOVjiZLRtXsXrFIomb0DGsbfC+AlygRj/sOC4HwSPQt8P4QeNraJ4N5hNkq6uH9Goi7suRkE+II3pL034X+lgdJcQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQfaDh+pTda1qjhvMFms4ZPJyPiNcCwJriD9MNT8s3uMJU8KBJ
	t2S9U6cXk+ck8MzUFzo3ooflCheWzdLLUpQvZbd1bPDsmuFWp5vUoFy+t27ArqwB1Tjd8l0mNmS
	6TByFVpdcSn97jHcHTD0Ehxeqw+tzwfwwfepfdCBl
X-Received: by 2002:a05:6512:ad3:b0:5ba:3602:4343 with SMTP id
 2adb3069b0e04-5bcdf94d4a0mr81856e87.16.1791556818070; Fri, 09 Oct 2026
 07:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009132848.709379-1-vdonnefort@google.com>
In-Reply-To: <20261009132848.709379-1-vdonnefort@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 9 Oct 2026 15:39:41 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzaDY=tcekBeR-QQwep-WGFjpT5pGczddFFBqCeupe9Gg@mail.gmail.com>
X-Gm-Features: AclHuK8GIOxUHp6icwuslMOwolFoLyUhJLGzQM0c0cvOf4PeuIievjOYVDcfRLQ
Message-ID: <CA+EHjTzaDY=tcekBeR-QQwep-WGFjpT5pGczddFFBqCeupe9Gg@mail.gmail.com>
Subject: Re: [PATCH v1] tracing/remotes: Align field offset in remote_event_format_show()
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Fri, 09 Oct 2026 14:28:48 +0100, Vincent Donnefort
<vdonnefort@google.com> wrote:

> remote_event_format_show() doesn't take into account each field's
> alignment leading to an incorrect reporting of the actual field offset.
> Use the existing field->align.

Tested in pKVM: the format files under remotes/hypervisor now report
hyp_enter's vcpu at offset 4 and selftest's id at 8, matching the
structs, and the hypervisor ftracetest still passes.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
