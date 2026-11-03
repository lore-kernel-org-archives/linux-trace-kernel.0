Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793731561;
	b=WjxXK79hO/OOHIilizxgg/UfmLxxtB7/bTD0XO1kqpJ61cYEyFqkvywTNnYiLTZu9JPd
	 Y7zLzkrfsejOUZUE6csYpmavfBUqsB5WD/LCR/mDs7gIrDlRX6Y338SDZ4JDFR/Kx/vTm
	 qA3LXX5z7bMYjpAxDrjH5P61xxce1RojqSj0pqC9Q5grkprYg6kOL10haBcXYOAwppcO4
	 jxNXjgTtYdEUHrw1MxCip9F8rkUHh8Yp1jfKDw9ajxGWNsDtF9Gj239D4s36jgf9Oej+2
	 YlUATTnuoAqXi9wmIwQQls6HMfiEtxHEcPqYfJC4B7tzU5wXsh7dXvRLrnnQDsVkjYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731561;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=XHlB01RhrQVohJxZtXM1n+7UdY7DXf2Fx2vn2sBbyTk=;
	b=a6nl5EIUmvG05voaX/VHcNGwSkS1PndnBwohs/Hy+96jR0M/iaO2N3YpjLNwSubKg5Si
	 TznxB1GZC6ih4aOB2GB8Krvadb/lXhK94s67feF/KljGw0d/wsuIy2O4zUFYuTV+xl4y4
	 Lf78LSTdK6QoelHNKdF6mxC3HOBDYI97Lqk70ZhuoeSJ0fpLaKl3V5pBZTrD3T8ygpRNO
	 70mhAvbeUtz0luf39SCkwXRymJrXMqyqHTtk328KEWROLcxVSBIa4SfXEmkQblzy5AW0P
	 l6zKfdomxhU4tKt25HwiFTcdMjG0mW5nJJaqnBZjgL1oaWgfTic6Cn4CTbCUBwQpyAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnfF1oti;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E9606A324;
	Tue,  3 Nov 2026 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnfF1oti
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793731560;
	b=HkddNICvYWtwlOPILaBQtMvBtLmiefFx/qovsEGJjF5uvrF0x3evdJAfeyvs6cmq6wJ6
	 v4bDtSxyzd5h0xt5SS+MLQOWXoYchPgZPBpfr8Ok152iMl0RsOD+94AKCQ8c4drlfY4dB
	 hFX/IV+PbygxJlGvYoUEPBHdzomrfPYbQPhq2W+EzygZvz3y8geqbXz+zxe182taTc3P1
	 I5XJLzDpAGEC0iUE+CckjWiBegbZo+Au7w6Z/Z9DRFsRtbHcVQnzpnZMXe7/PMHPYQWhW
	 Os3OdeEsbeGt1OexnkjKUa22XNSUycw6xa5/T2NHAn1y0spwpIXJD4Vj+369oYxOavw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793731560;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=XHlB01RhrQVohJxZtXM1n+7UdY7DXf2Fx2vn2sBbyTk=;
	b=c+22P6TMQAMgBNWbj1nU16a64jnzaX3euZzS48satr0tTUcQXBbJiffEZsAoEBl8RSKh
	 5QQ9PRGGYKFWOFOVFOYx++pSiAbq4Ki+gsCAs5k9RvVRAKc1GHfe6TkzP7ekubxxCjqdl
	 gbaK6uViSMTd/1OIAwhb7fMIrrZhpIuHE8Kg1Aypqj+N8EOoTC5APoqjeRkUpHwLjSunJ
	 pJQBWwMP5i0xj28/VQAYW8oLEJ5KrMsbqVLoyS8BFU37BVaEm0S539lhBwL39N6ilH0YO
	 0d+i5QBAHGK+afP84j3NPMi8pBGEYhRS9Ny7FtcYaYz/WeEEIBcSlogGXoCL2IRQvlQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 60F681F0093A;
	Tue,  3 Nov 2026 18:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731560;
	bh=XHlB01RhrQVohJxZtXM1n+7UdY7DXf2Fx2vn2sBbyTk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=LnfF1otihmPsM0b8OqarottaEzNqKK+mA7KD5sqoNkqe3Oy6ZoRWSr4L2geWy3qb7
	 g4QUy3pFClE25Ob5qy4ARq3oaLX5MyT5C85XGstK7z2mFXXmv4N95aitnWJQk2P/vz
	 wboQ+KIxnF1SFkpGaV/x/HwVKM2KdvQvtPc7eCfIhtslwU2/aNm9HAvjOMQSxu2qK0
	 EkdAcsdCAL1k1YLD9CAmsXiAtevzXNZqvj3QU723x1NqmgM2whiUoZdKD/thq+r3H5
	 OiS/sFcBIeKWvwjljLP2TayOasm5Imnv3qxgfJB9qfb01lmly5Gbd2HHcfSAkhW4RH
	 v9pJBOtqrfeXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B356346A9A;
	Tue,  3 Nov 2026 18:45:59 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Subject: [PATCH 0/3] kprobes: Fix optprobe state after forced
 unoptimization
Date: Tue, 03 Nov 2026 13:45:58 -0500
Message-Id: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWTuQxAvYVykukji2U8GETCwF8
 d2Ndne+xfl3EEpMAo9qh0RfFg5rga4r8G+7vgh5KgajTK+1anCJKTgSDDHfCyXbTDioyc1d50z
 beyjnmGjm3x1+jn/L5j7k81WD4zgB6lfn23oAAAA=
X-Change-ID: 20261103-kprobes-optprobe-state-90dbf55b246c
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Naveen N Rao <naveen@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793731559; l=894;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=v3BKc1evNNgx9JvFdRpY0RryPKMmTA+gZSS3xlFLPnc=;
 b=UQNWImAOO0ZadHFcyte7seIeHtCgwwKU5i3xOSY9AjWFqb2n2xN6rjmcf+6L89qxbdQviYtCT
 rcwjO8HDhwMCYoqvUx9jAyZMZgJFykiu5e2VtSdpTC7nWU7I9yBz/yW
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu

Since commit 06e0d3b89da1 ("kprobes: Make optprobe optimizer
multi-generational and asynchronous") a forced unoptimization can leave
a probe's int3 in the wrong state.  A disabled probe can be freed with
its int3 still in the text, an unhashed probe gets disarmed twice and a
reused probe never gets armed.

Patch 2 relies on patch 1 since it assumes every disabled probe on a
cooling list is already disarmed.

---
Mani Tofigh (3):
      kprobes: Disarm disabled optprobe on forced unoptimization
      kprobes: Do not disarm unhashed optprobe on dispatch
      kprobes: Arm reused optprobe on cooling list

 kernel/kprobes.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)
---
base-commit: d4d028a7ae6401ce70825a3eb663f0a2dfc49db6
change-id: 20261103-kprobes-optprobe-state-90dbf55b246c

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


