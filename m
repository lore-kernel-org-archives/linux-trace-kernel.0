Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C70425CEE;
	Wed, 20 May 2026 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302818; cv=none; b=pWzBsHsgKShj+yJrXIdl77IzIeB1gCq33+IYpjyRQTSJEbV5XvUJBO24zGekF3XZ3+d+DJduHkGZNtB/NyKZhRgHB8kRp1Gl+/e4lgj/VoxNFK7Ws4gq2SBQ0QEAamYbh5TIVSMWpVEoNrlfjuzzf4E3fviZCOAxSjIJb5QBym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302818; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:From:To; b=VT1FEJzayTYfeXl6TVNMo+4M7g+fq4lHm8T5T+h6V2zGBVHvoCNVheh8RHkb1YeDa/Y4TZGj/VOjd8HRTbTAzVr2KRYBSvFsRYbZoW9qus8rXFTzRvGVzO2nTmBbKShi7JHcdgqiVHEHbzB8SGqLMZyAg7NJ+9XKIxve9nPBAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8GBZDxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8GBZDxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5781F00893;
	Wed, 20 May 2026 18:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302816;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; h=Date:From:To;
	b=S8GBZDxWCVMLaFoTqI/eRIsOPAVjqg9Rv7/wIq68Da32gyXOCTaymtjZyGjus8vqI
	 vvixmkyxtoWclg4Jk+lMGXcfG4JHtNNmtWlwjr+GEzXa3evmYde5xO95B3tp5LlWu7
	 SL3fLNmNUP38idDCbPXIoD/DN1AbyXxypAGJ+IbrzeeImnkTUWCpbHKWsYtlERkxTd
	 w1XWhs9j3nwu4FM9Dgt203T9p439ehbxj36eBsmIM4T7OWvRILijw8QpIGlx6vyNNo
	 BGcusSoC/aY6MH5VwGLm/mqVqupeYrPicypGgaFtq4Zq5t2k31Y0S7OjTgQq0estRW
	 DdrqtuqHCfV6Q==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wPlwq-00000004qFr-0iax;
	Wed, 20 May 2026 14:47:16 -0400
Message-ID: <20260520184510.766026238@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 20 May 2026 14:45:10 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

