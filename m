Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3B36B045
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342666; cv=none; b=b2mYjEYUmosg1ow1DOiOOnpzllzIFD8ABybU7WAjz40V/KYbNUaBgUVZ68y7/lq235yXFkqEZ62mxHovS15HdmzaACCg2XNsEh7DqeSK1P1KNq33b7IW+oMhYqWCMEB6Z7iBP5gAhhoxpV0EMty9SBEDI6UfLU0LRf/HnXs5Z6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342666; c=relaxed/simple;
	bh=6xJwD16IDJRZDQYHif+SFrdSoYC07tw5lE7UhNAkGMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UO+FSIZkedrdzAQvhYF4pMhR3L7dSP8R0ATd0AXLx7d6pl8HomgKIS8BwhWyT6tTVNX78mc2o0K1SdAEwYm2IvxBpm08+l733DQcSY7YNnRwNBAVIbsZpdQ2PmghHG1Pg8jU5KALDDwDPBuJXjawgA5L0s44dRmAxLmlxW8MtBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zJpJ9j6H; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zJpJ9j6H"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45f04f1348cso2882623b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 07:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771342664; x=1771947464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tci0PLQEn0PJVJPz0FvG5ueLsMUUWMKAN2gZo/UYijU=;
        b=zJpJ9j6HJy20ywEe08SaAGe4bm5FHVmn5ZIjpAMUVV4ZyUTht6SW/BI9nEzJd7ic77
         DitBg64hL0VnoNcE63zoRPpnzJ3vIKwUDu9BLrSA4PT/4nZ6zzjosc2VHC+Bz0FNbNQ6
         xtITuN5bVza+HjW6o9XrHhK7Ao7ugGGo+9Tfx8GHCtipHYTW+1OT5rX4R/RAcPB1kJ3V
         1HQD04fpUmwCJv3kUB8D7CyNCxKNz0+Ly1+p9RyJgjuc95HlpVX+jH3wzWCvTXJz5tpR
         TIA/u13Vhau3XzKXSMiG6zmnL2hKD9iEvdy5W1aZjPSrecaXTnmjtSzEna2iLxiI/pWf
         k0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342664; x=1771947464;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tci0PLQEn0PJVJPz0FvG5ueLsMUUWMKAN2gZo/UYijU=;
        b=V1knTV1HGsDDoARl+Q85DbmXrJmSWYtTRKSqBm6hdC78IPD7NEx+kyRRrTxhvvW5NF
         GH5AmD8PSf0maDYz5bCsLILi+P4sEqnTRmPCH098xcKSA8s+ZWMia6NsT/OlHsvwAGA3
         PlQ86nORB98EhmE/ldWi6YWJNQP9InnKAbXiAhSBg0DjQ9FVEJiVSO0npyvkh3X3safi
         8RCTFBrpuzPsmF56PwzwnOmU00eLwqO9ILh1tAk59pBh1jW8yiQoefbndj5i4p0MoDSc
         rSApMzuil6RkgE54JfRu7FUlr0IGUUWIdn05kzNd7FzA8CLcZ40TGl+Ty860ZisU9Ztv
         rAhA==
X-Forwarded-Encrypted: i=1; AJvYcCW6osfIkpNr0QvAGZWWHp7/gAXq50+ZzBHiJszuZ/kA9UOZZGiHKCzsMOh4Zl5Rfbzf+GVWlb2HNYm1UB48DXna0e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUpRqGKO1at89id8WdLeTbOuz3c/Yhqwndv3yOkqLoWMxQvx5
	Fn+QmGoD/8vA6KIP4M5ouoSl2j9yxOwQUPO4i3Gn87a/tp/Zad2iXStpM/zzq98bXjs=
X-Gm-Gg: AZuq6aLRd6lKu8QnIcqzRrJADbQSilfHykSoV2bvQ2zKvYs3J45OK0duH62z1pSLCKy
	n3Kb7A1aUukkW7byTO1nFm9wvp+cUKX0/v6I7Yleaj7iBt1BEOuhAFxsNxwsjt+NWGKIfbPXA4s
	GbACkM3nidxaxKGyLh2VjYDMhf16EwN4uaJXC2eWz68gqqrISKjjmQ6sIf8ghum6AT8Czgg7T0/
	J1RVWw2dmFwERa9rjNTOe9BCe2ro+94Fz4sRhTmYqfSGszp74Xitu5fyXlmleyqcKl+afLd3gqn
	xyiMp1LgqrtyBmjHkly5MxD64kOQnsfUXKN/+uigN/HS9BovPHwLgNHNCR/6H6ZF+iYT6/+2pUO
	T0OBvs0zYqXR0q3S9dZ5NV3jCjMlo2aKMMMiC+/P4zhlmahM46tLFsq2fUVkqAvq6UOkzyxWejq
	BV7xye1IJcbzZmFqLcTirMC53V1PysYJif1C8/Wb5vpaBRKCTpkx8tHWlcxfDKrTwfnTO6bG3YN
	NjS
X-Received: by 2002:a05:6808:2445:b0:450:5e3a:6f1a with SMTP id 5614622812f47-463b3f655e2mr6138488b6e.20.1771342663817;
        Tue, 17 Feb 2026 07:37:43 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40f18df8a64sm9718229fac.14.2026.02.17.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 07:37:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: nilay@linux.ibm.com, ming.lei@redhat.com, hch@lst.de, 
 Yu Kuai <yukuai@fnnas.com>
Cc: yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, kbusch@kernel.org, 
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260214054350.2322436-1-yukuai@fnnas.com>
References: <20260214054350.2322436-1-yukuai@fnnas.com>
Subject: Re: [PATCH v2] blk-mq: use NOIO context to prevent deadlock during
 debugfs creation
Message-Id: <177134266269.373694.2745476582847973429.b4-ty@kernel.dk>
Date: Tue, 17 Feb 2026 08:37:42 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 14 Feb 2026 13:43:50 +0800, Yu Kuai wrote:
> Creating debugfs entries can trigger fs reclaim, which can enter back
> into the block layer request_queue. This can cause deadlock if the
> queue is frozen.
> 
> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
> to detect this condition, but it was racy since the queue can be frozen
> from another context at any time.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: use NOIO context to prevent deadlock during debugfs creation
      (no commit info)

Best regards,
-- 
Jens Axboe



