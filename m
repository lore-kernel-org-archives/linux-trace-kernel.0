Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB552290F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183875; cv=none; b=AUTke0IvlOyeiEr0ZQ9WTECJTdcnLrf5UMDRtf9bjh4yDKVi5XdC/HdaYskphVjEa/PcBBPkuPLDUXCvqVIsDk+tcLKFVK/QW47owMl6C3+u0ip8Ekq3/1d1Xz4L/9+kw2unEfVXeNouHkI5oHo3JM47rQYYUeUlRQfJ3XouCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183875; c=relaxed/simple;
	bh=jLYGDQwIGSlxtnBBjWbPmJm93ml5hhOv9he4uGhp5yw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r1pevxCoIqMRHMkSoJqau9UCxQFcT+oIgcJqZzhC3Uo0izOvVxQIoKsEw8arvkkdcTSzpuT4QpMC0pci6hZGVBIQKlT9CJpjbP34AZz9iuQEr94iLUOes8wbJv6V64TfH4y1AMHDPAIXYmzKPNUhKCuMSC5BZ60R13JCnAFysSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vs2DMvx8; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vs2DMvx8"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-940d25b807bso182196639f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762183871; x=1762788671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQursU3vQn5dcAzH80PaV+pMX8Ep5Hc5g1Bu5Rspys4=;
        b=vs2DMvx8LShsW/nRBEzkUAnakPhs+nqgqvKbCk8uvMckEV/j+MachiaUSRFsgy9kd7
         rPJabIlHMHr1s+IfyH+rEIPI9Jrzjhi2WCoSit/nJV7JKhdwja44yBjverSWQvpfTYlF
         U2TfXhx8Nwpfqrs4zfROwqu9k7tnrFZncpS13fWi/g20sJzJg9kAhLNjjEDyiL7dQce5
         wusYrCxtCLfKJsgatoPvMHOxT+AvKCpoo4WIPzgYZCpBZZO/1YMS0VrZ5We+LwDV7pWH
         Y1rHcZLeuR8tIg3rx1zgbDbo5XkHqapM1DDWgHLOoIZfIY6WrBKxf000yse6vCuxFRNN
         jHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183871; x=1762788671;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQursU3vQn5dcAzH80PaV+pMX8Ep5Hc5g1Bu5Rspys4=;
        b=BtV9oircdRFH9yfrxMgF1oTBhGcAOLCEqsVl8G/1mUp9shHAwagzh8W4/caYaRK05B
         vrNzRuHfRhnXG2wg28lx0acTSaJYbeLW4AdfbIJxyl+UP3TRr/VRl96S1O01LdclhrTo
         jfXG0v9Q/M7raaJWe3ON/HpYdN05FwE21MGH3kEO4CenCWAzlmwBdZgtpdtslJrv8OyE
         nw9+AZr6Z0kmMqzYMUe5NOXl1XJvGEK+xJZLvThVmJebM+XiVFoPkdK94MpcwYVlAQn7
         ArAqhiMPtkWRDiQIvbIJI2IVTxxhkmRlBmUanm46a8e+8MXRv7DgiIjjs8HTgiSxw0HR
         YjKA==
X-Forwarded-Encrypted: i=1; AJvYcCWhCH/EOhkx4phU2/f3SwAMwG+WpcY48Y9pJXuo6/ZjGztxdA/fC33A1+Zqoqv+ck4oJRM3Oa5yiYo3ewBVkvJLNcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02lT5orTOpjz36HmUOTGc4FCiP9ODbu1xL0QEGAQOTCPj0zbr
	rHj/S2u+RpsDoCaEBE42yMr37IE2byPF9ZDIHzBRxzgBX0HHfLX8GCekDKXIOlwXSoQ=
X-Gm-Gg: ASbGnctgz1gwZSueKlTdzrusb9RYZmKUs419hCGSBsUvfrerznIw0KgDoVMVy7++QU0
	vERGd0TgwwE3TqvT3WnI4Xu6Doyy7o9+8KqHJaESdIT/urPFswfs4pRQ61RPZMYmBJ89YoW9ptC
	CYkideGe3UlRnV1/2fub3Y7YSLywR0y1KFnQ2X+XkhEef0NfB2DC1flNc78B59NPQ7H70uu6Jjv
	JxAuKBUcNkPcWEtU9v81/aqKGvmiYavMSt8B+uBlA1y5LewJe4EJ3NsIrRDQd6LOdWulWqWgbwv
	OoHTJCjKXBFk/qXaaF9l/bM5Zbyyd+P00Kcr84ZpNBHaL2WsC/c8668fcZ271J+NikDhu7oZ4uZ
	lsKakjpBrYi5OepV9UQpyfCzRGR3YEd8PtX0etz3UBIturMRIvYqonl21KLVxg8F3+PGY3DHGTu
	Y6dw==
X-Google-Smtp-Source: AGHT+IF9uCw+Dm4cAoPCKQ1Nmzm4tgHllBHAPxJuIpHuhQW4LAzI5jodlVMbim8JF8xCf9Hlx/UJIw==
X-Received: by 2002:a05:6e02:10:b0:433:3505:51c2 with SMTP id e9e14a558f8ab-433350553a8mr18998285ab.9.1762183870566;
        Mon, 03 Nov 2025 07:31:10 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9485517b875sm22472039f.20.2025.11.03.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:31:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: johannes.thumshirn@wdc.com, 
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, martin.petersen@oracle.com, 
 dlemoal@kernel.org, john.g.garry@oracle.com, linux-block@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20251029033423.7656-1-ckulkarnilinux@gmail.com>
References: <20251029033423.7656-1-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH 1/1] blktrace: add support for REQ_OP_WRITE_ZEROES
 tracing
Message-Id: <176218386919.6125.17209556415217535516.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:31:09 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 28 Oct 2025 20:34:23 -0700, Chaitanya Kulkarni wrote:
> Currently, REQ_OP_WRITE_ZEROES operations are not handled in the
> blktrace infrastructure, resulting in incorrect or missing operation
> labels in ftrace blktrace output. This manifests as write-zeroes
> operations appearing with incorrect labels like "N" instead of a
> proper "WZ" designation.
> 
> This patch adds complete support for REQ_OP_WRITE_ZEROES across the
> blktrace infrastructure:
> 
> [...]

Applied, thanks!

[1/1] blktrace: add support for REQ_OP_WRITE_ZEROES tracing
      commit: bc49af56eea866c34d21bf582f65b02fc8c06ec3

Best regards,
-- 
Jens Axboe



